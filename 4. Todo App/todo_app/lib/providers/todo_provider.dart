import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';

class TodosNotifier extends AsyncNotifier<List<TodoModel>> {
  // Build -> Get all tasks
  @override
  Future<List<TodoModel>> build() async {
    return await TodoService.getAll();
  }

  // Change current state with tasks by status
  Future<void> getByStatus(bool isCompleted) async {
    final resultTodos = await TodoService.getByStatus(isCompleted);

    state = AsyncData(resultTodos);
  }

  // Return a task by id
  Future<TodoModel?> getById(int id) async {
    return await TodoService.getById(id);
  }

  // Change current state with search tasks
  Future<void> search({
    required String keyword,
    required bool isCompleted,
  }) async {
    final resultTodos = await TodoService.search(
      keyword: keyword,
      isCompleted: isCompleted,
    );

    state = AsyncData(resultTodos);
  }

  // Clear list highlight ids before loops
  // For list selected ids: update tasks's status in DB, update tasks for state (Provider)
  // save tasks ids in highlight todo ids provider (add more to current ids,
  // Clear list highlight ids after loops 3 seconds, and call getByStatus again
  Future<void> setStatus({
    required Set<int> ids,
    required bool setCompleted,
  }) async {
    final idsNotifier = ref.read(
      TodoProvider.highlightedTodoIdsProvider.notifier,
    );
    idsNotifier.state = {};

    var todos = state.requireValue;

    for (final id in ids) {
      final newTodo = await TodoService.setStatus(
        id: id,
        setCompleted: setCompleted,
      );

      if (newTodo == null) continue;

      todos = todos.map((todo) {
        return todo.id == id ? newTodo : todo;
      }).toList();
    }

    state = AsyncData(todos);
    idsNotifier.state = {...ids};

    await Future.delayed(const Duration(seconds: 3));

    if (!ref.mounted) return;

    idsNotifier.state = {};
    await getByStatus(setCompleted);
  }

  // Add tasks in DB, add task for state (Todos provider),
  // save task id in highlight todo ids provider (only this task's id)
  // Call getByStatus again
  Future<void> add(String content) async {
    final newTodo = await TodoService.add(content);
    final idsNotifier = ref.read(
      TodoProvider.highlightedTodoIdsProvider.notifier,
    );

    if (newTodo != null) {
      final todos = state.requireValue;
      state = AsyncData([...todos, newTodo]);

      idsNotifier.state = {newTodo.id};

      await Future.delayed(const Duration(seconds: 3));

      if (!ref.mounted) return;

      idsNotifier.state = {};
      await getByStatus(newTodo.completed);
    }
  }

  // Update task in DB, update task for state (Todo provider),
  // save task id in highlight todo ids provider (change current ids to this id)
  // Call getByStatus again
  Future<void> edit({required int id, required String updatedContent}) async {
    final updatedTodo = await TodoService.update(
      id: id,
      updatedContent: updatedContent,
    );
    final idsNotifier = ref.read(
      TodoProvider.highlightedTodoIdsProvider.notifier,
    );

    if (updatedTodo != null) {
      var todos = state.requireValue;
      todos = todos.map((todo) {
        return todo.id == id ? updatedTodo : todo;
      }).toList();
      state = AsyncData(todos);

      idsNotifier.state = {updatedTodo.id};

      await Future.delayed(const Duration(seconds: 3));

      if (!ref.mounted) return;

      idsNotifier.state = {};
      await getByStatus(updatedTodo.completed);
    }
  }

  // Delete task in DB, delete task for state (Todo provider),
  // Call getByStatus again
  Future<void> delete(int id) async {
    final deletedTodo = await TodoService.getById(id);
    bool isDeleted = await TodoService.delete(id);
    if (isDeleted) {
      final todos = state.requireValue;

      state = AsyncData(todos.where((todo) => todo.id != id).toList());
      await getByStatus(deletedTodo!.completed);
    }
  }
}

class TodoProvider {
  TodoProvider._();

  static final todosProvider =
      AsyncNotifierProvider<TodosNotifier, List<TodoModel>>(TodosNotifier.new);

  static final highlightedTodoIdsProvider = StateProvider<Set<int>>(
    (ref) => {},
  );
}
