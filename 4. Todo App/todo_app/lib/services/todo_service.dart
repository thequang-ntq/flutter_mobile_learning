import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_app/models/todo_model.dart';

class TodoService {
  static const String _todosKey = 'todoList';
  static const String _searchHistoryKey = 'searchHistory';
  static const String _searchHistoryCompletedKey = 'searchHistoryCompleted';
  static const int _maxHistory = 5;

  static Future<List<TodoModel>> getAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_todosKey);

      if (jsonString == null) {
        return [];
      }

      final List<dynamic> jsonData = json.decode(jsonString);

      final todos = jsonData.map((e) {
        return TodoModel.fromJson(e);
      }).toList();

      todos.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return todos;
    } catch (e) {
      return [];
    }
  }

  static Future<List<TodoModel>> getByStatus(bool isCompleted) async {
    final todos = await getAll();

    return todos.where((todo) {
      return todo.completed == isCompleted;
    }).toList();
  }

  static Future<TodoModel?> getById(int id) async {
    final todos = await getAll();

    try {
      return todos.firstWhere((todo) {
        return todo.id == id;
      });
    } catch (e) {
      return null;
    }
  }

  // Search
  static Future<List<TodoModel>> search({
    required String keyword,
    required bool isCompleted,
  }) async {
    final todos = await getAll();
    final lowerKeyword = keyword.toLowerCase();

    return todos.where((todo) {
      return todo.completed == isCompleted &&
          todo.content.toLowerCase().contains(lowerKeyword);
    }).toList();
  }

  static Future<List<String>> getSearchHistory(bool isCompleted) async {
    final prefs = await SharedPreferences.getInstance();
    final key = isCompleted ? _searchHistoryCompletedKey : _searchHistoryKey;

    return prefs.getStringList(key) ?? [];
  }

  // Delete if keyword already in list and get the current keyword to the top of list
  static Future<void> saveSearchKeyword({
    required String keyword,
    required bool isCompleted,
  }) async {
    if (keyword.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final key = isCompleted ? _searchHistoryCompletedKey : _searchHistoryKey;

    final history = prefs.getStringList(key) ?? [];

    history.removeWhere((e) => e.toLowerCase() == keyword.toLowerCase());
    history.insert(0, keyword);

    if (history.length > _maxHistory) {
      history.removeRange(_maxHistory, history.length);
    }

    await prefs.setStringList(key, history);
  }

  static Future<List<TodoModel>> setStatuses({
    required Set<int> ids,
    required bool setCompleted,
  }) async {
    try {
      final todos = await getAll();

      for (final id in ids) {
        final index = _findIndex(todos, id);

        if (index == -1) return todos;

        todos[index] = TodoModel(
          id: todos[index].id,
          content: todos[index].content,
          completed: setCompleted,
          timestamp: DateTime.now(),
        );
      }

      await _saveTodos(todos);

      return todos;
    } catch (e) {
      throw Exception("Failed to change statuses of tasks");
    }
  }

  static Future<TodoModel?> add(String content) async {
    try {
      final todos = await getAll();
      final maxId = todos.isEmpty
          ? 0
          : todos
                .map((e) {
                  return e.id;
                })
                .reduce((a, b) {
                  return a > b ? a : b;
                });

      final newTodo = TodoModel(
        id: maxId + 1,
        content: content,
        completed: false,
        timestamp: DateTime.now(),
      );

      todos.add(newTodo);
      await _saveTodos(todos);

      return newTodo;
    } catch (e) {
      throw Exception("Failed to create task");
    }
  }

  static Future<TodoModel?> update({
    required int id,
    required String updatedContent,
  }) async {
    try {
      final todos = await getAll();
      final index = _findIndex(todos, id);

      if (index == -1) return null;

      todos[index] = TodoModel(
        id: todos[index].id,
        content: updatedContent,
        completed: todos[index].completed,
        timestamp: DateTime.now(),
      );

      await _saveTodos(todos);

      return todos[index];
    } catch (e) {
      throw Exception("Failed to update task");
    }
  }

  static Future<bool> delete(Set<int> ids) async {
    try {
      final todos = await getAll();
      final initialLength = todos.length;

      for (final id in ids) {
        final index = _findIndex(todos, id);

        if (index == -1) return false;

        todos.removeWhere((todo) {
          return todo.id == id;
        });
      }

      if (todos.length == initialLength) return false;

      await _saveTodos(todos);
      return true;
    } catch (e) {
      throw Exception("Failed to delete tasks");
    }
  }

  static int _findIndex(List<TodoModel> todos, int id) {
    return todos.indexWhere((todo) {
      return todo.id == id;
    });
  }

  static Future<void> _saveTodos(List<TodoModel> todos) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(
        todos.map((todo) => todo.toJson()).toList(),
      );
      await prefs.setString(_todosKey, jsonString);
    } catch (e) {
      throw Exception("Cannot save data");
    }
  }
}
