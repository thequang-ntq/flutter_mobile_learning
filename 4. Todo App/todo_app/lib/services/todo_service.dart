import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/constants.dart';

class TodoService {
  static Future<List<TodoModel>> getAll() async {
    final jsonString = await rootBundle.loadString(
      "${Constants.baseJsonUrl}/todos.json",
    );
    final List<dynamic> jsonData = json.decode(jsonString);

    final todos = jsonData.map((e) {
      return TodoModel.fromJson(e);
    }).toList();

    todos.sort((a, b) {
      return b.timestamp.compareTo(a.timestamp);
    });

    return todos;
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

  static Future<TodoModel?> setStatus({
    required int id,
    required bool setCompleted,
  }) async {
    final todos = await getAll();
    final index = _findIndex(todos, id);

    if (index == -1) return null;

    todos[index] = TodoModel(
      id: todos[index].id,
      content: todos[index].content,
      completed: setCompleted,
      timestamp: DateTime.now(),
    );

    await _saveTodos(todos);

    return todos[index];
  }

  static Future<TodoModel?> add(String content) async {
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
  }

  static Future<TodoModel?> update({
    required int id,
    required String updatedContent,
  }) async {
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
  }

  static Future<bool> delete(int id) async {
    final todos = await getAll();
    final initialLength = todos.length;

    todos.removeWhere((todo) {
      return todo.id == id;
    });

    if (todos.length == initialLength) return false;

    await _saveTodos(todos);
    return true;
  }

  static int _findIndex(List<TodoModel> todos, int id) {
    return todos.indexWhere((todo) {
      return todo.id == id;
    });
  }

  static Future<void> _saveTodos(List<TodoModel> todos) async {
    // Use shared preferences to save into json file (root bundle just read)
  }
}
