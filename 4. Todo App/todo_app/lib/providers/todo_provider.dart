import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/models/notification_message.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/search_provider.dart';
import 'package:todo_app/providers/toast_provider.dart';
import 'package:todo_app/services/todo_service.dart';

class TodosNotifier extends AsyncNotifier<List<TodoModel>> {
  final bool isCompleted;
  String? _keyword;

  TodosNotifier(this.isCompleted);

  // Build -> Get all tasks
  @override
  Future<List<TodoModel>> build() async {
    return await TodoService.getByStatus(isCompleted);
  }

  Future<void> refresh() async {
    if (_keyword == null || _keyword!.isEmpty) {
      state = AsyncData(await TodoService.getByStatus(isCompleted));
    } else {
      state = AsyncData(
        await TodoService.search(keyword: _keyword!, isCompleted: isCompleted),
      );
    }
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
    _keyword = keyword;

    final resultTodos = await TodoService.search(
      keyword: keyword,
      isCompleted: isCompleted,
    );

    state = AsyncData(resultTodos);

    await TodoService.saveSearchKeyword(
      keyword: keyword,
      isCompleted: isCompleted,
    );

    ref.invalidate(SearchProvider.searchHistoryProvider(isCompleted));
  }

  void clearSearch() {
    _keyword = null;
  }

  // Clear list highlight ids before loops
  // For list selected ids: update tasks's status in DB, update tasks for state (Provider) - delete updated task from state
  // Add status todos on the top of status list
  // save tasks ids in highlight todo ids provider (add more to current ids,
  // Clear list highlight ids after loops 3 seconds, and call getByStatus again
  Future<void> setStatuses({
    required Set<int> ids,
    required bool setCompleted,
  }) async {
    try {
      final idsNotifier = ref.read(
        TodoProvider.highlightedTodoIdsProvider.notifier,
      );

      final targetNotifier = ref.read(
        TodoProvider.todosProvider(setCompleted).notifier,
      );

      final allTodos = await TodoService.setStatuses(
        ids: ids,
        setCompleted: setCompleted,
      );

      var todos = allTodos.where((todo) {
        return todo.completed == isCompleted;
      }).toList();

      state = AsyncData(todos);

      await targetNotifier.refresh();

      idsNotifier.state = {...ids};

      ref
          .read(ToastProvider.toastProvider.notifier)
          .state = NotificationMessage(
        message: "Change tasks's statuses successfully",
        status: "success",
      );
    } catch (e) {
      ref.read(ToastProvider.toastProvider.notifier).state =
          NotificationMessage(message: e.toString(), status: "failed");
      rethrow;
    }
  }

  // Add tasks in DB, add task for state (Todos provider),
  // save task id in highlight todo ids provider (only this task's id)
  // save message & status in toast provider
  Future<void> add(String content) async {
    try {
      final newTodo = await TodoService.add(content);
      final idsNotifier = ref.read(
        TodoProvider.highlightedTodoIdsProvider.notifier,
      );

      if (newTodo != null) {
        state = AsyncData([newTodo, ...state.requireValue]);
        idsNotifier.state = {newTodo.id};
      }

      ref
          .read(ToastProvider.toastProvider.notifier)
          .state = NotificationMessage(
        message: "Create task successfully",
        status: "success",
      );
    } catch (e) {
      ref.read(ToastProvider.toastProvider.notifier).state =
          NotificationMessage(message: e.toString(), status: "failed");
      rethrow;
    }
  }

  // Update task in DB, update task for state (Todo provider),
  // save task id in highlight todo ids provider (change current ids to this id)
  // delete editingId
  Future<void> edit({required int id, required String updatedContent}) async {
    try {
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

        ref.read(TodoProvider.editingTodoIdProvider.notifier).state = null;

        ref
            .read(ToastProvider.toastProvider.notifier)
            .state = NotificationMessage(
          message: "Update task successfully",
          status: "success",
        );
      }
    } catch (e) {
      ref.read(ToastProvider.toastProvider.notifier).state =
          NotificationMessage(message: e.toString(), status: "failed");
      rethrow;
    }
  }

  // Delete tasks in DB, delete tasks for state (Todo provider)
  Future<void> delete(Set<int> ids) async {
    try {
      var todos = state.requireValue;

      final isDeleted = await TodoService.delete(ids);

      if (isDeleted) {
        state = AsyncData(
          todos.where((todo) => !ids.contains(todo.id)).toList(),
        );
      }

      ref
          .read(ToastProvider.toastProvider.notifier)
          .state = NotificationMessage(
        message: "Delete tasks successfully",
        status: "success",
      );
    } catch (e) {
      ref.read(ToastProvider.toastProvider.notifier).state =
          NotificationMessage(message: e.toString(), status: "failed");
      rethrow;
    }
  }
}

class TodoProvider {
  TodoProvider._();

  // List todo
  static final todosProvider = AsyncNotifierProvider.autoDispose
      .family<TodosNotifier, List<TodoModel>, bool>(TodosNotifier.new);

  // List highlight id
  static final highlightedTodoIdsProvider = StateProvider<Set<int>>(
    (ref) => {},
  );

  // Editing id
  static final editingTodoIdProvider = StateProvider<int?>((ref) => null);

  // Editing todo
  static final editingTodoProvider = FutureProvider<TodoModel?>((ref) async {
    final id = ref.watch(TodoProvider.editingTodoIdProvider);

    if (id == null) return null;

    return await TodoService.getById(id);
  });
}
