import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/notification_message.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/selection_provider.dart';
import 'package:todo_app/providers/toast_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/home/widgets/home_body.dart';
import 'package:todo_app/screens/home/widgets/home_bottom_bar.dart';
import 'package:todo_app/utils/toast_notification.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ValueNotifier<Set<int>> _selectedTodoIds = ValueNotifier<Set<int>>({});

  @override
  void initState() {
    super.initState();
    _setupToastListener();
  }

  @override
  Widget build(BuildContext context) {
    final typeSelected = ref.watch(SelectionProvider.typeSelectedProvider);

    return Scaffold(
      body: HomeBody(
        typeSelected: typeSelected,
        onTypeButtonPressed: _onTypeButtonPressed,
        onCircleButtonPressed: _onCircleButtonPressed,
        onSelectAllButtonPressed: _onSelectAllButtonPressed,
        selectedTodoIds: _selectedTodoIds,
      ),
      bottomNavigationBar: HomeBottomBar(
        typeSelected: typeSelected,
        onConfirmDialogPressed: _onConfirmDialogPressed,
        selectedTodoIds: _selectedTodoIds,
      ),
    );
  }

  // Change type: todo / done for tasks
  void _onTypeButtonPressed(String name) {
    final currentTypeSelected = ref.read(
      SelectionProvider.typeSelectedProvider,
    );

    if ((!currentTypeSelected && name == "Done") ||
        (currentTypeSelected && name == "To do")) {
      ref.read(SelectionProvider.typeSelectedProvider.notifier).state =
          !currentTypeSelected;
    }
  }

  // Change mode: Watch/selected mode (for check, uncheck, delete)
  void _onCircleButtonPressed(int todoId) {
    if (!ref.read(SelectionProvider.isSelectionModeProvider)) {
      ref.read(SelectionProvider.isSelectionModeProvider.notifier).enable();
    }

    final currentIds = Set<int>.from(_selectedTodoIds.value);
    if (currentIds.contains(todoId)) {
      currentIds.remove(todoId);
    } else {
      currentIds.add(todoId);
    }
    _selectedTodoIds.value = currentIds;
  }

  // Select all tasks in selected mode
  void _onSelectAllButtonPressed(List<TodoModel> todos) {
    if (_selectedTodoIds.value.length == todos.length) {
      _selectedTodoIds.value = {};
    } else {
      _selectedTodoIds.value = todos.map((e) => e.id).toSet();
    }
  }

  // Select confirm for dialog in check/uncheck/delete function in selected mode
  void _onConfirmDialogPressed(String action, bool typeSelected) {
    final todosNotifier = ref.read(TodoProvider.todosProvider(false).notifier);
    final todosCompletedNotifier = ref.read(
      TodoProvider.todosProvider(true).notifier,
    );

    switch (action) {
      case "check":
        todosNotifier.setStatus(
          ids: _selectedTodoIds.value,
          setCompleted: true,
        );
        ref.read(SelectionProvider.typeSelectedProvider.notifier).state = true;
      case "uncheck":
        todosCompletedNotifier.setStatus(
          ids: _selectedTodoIds.value,
          setCompleted: false,
        );
        ref.read(SelectionProvider.typeSelectedProvider.notifier).state = false;
      case "delete":
        typeSelected
            ? todosCompletedNotifier.delete(_selectedTodoIds.value)
            : todosNotifier.delete(_selectedTodoIds.value);
    }

    _selectedTodoIds.value = {};
    context.pop();
    ref.read(SelectionProvider.isSelectionModeProvider.notifier).disable();
  }

  // Load add/update delete, check/uncheck success/failed notification using toast
  void _setupToastListener() {
    ref.listenManual<NotificationMessage?>(ToastProvider.toastProvider, (
      previous,
      next,
    ) {
      if (next != null) {
        if (next.status == "success") {
          ToastNotification.showSuccess(context, message: next.message);
        } else {
          ToastNotification.showError(context, message: next.message);
        }
        Future.delayed(const Duration(seconds: 3), () {
          ref.read(ToastProvider.toastProvider.notifier).state = null;

          final idsNotifier = ref.read(
            TodoProvider.highlightedTodoIdsProvider.notifier,
          );

          idsNotifier.state = {};
        });
      }
    });
  }
}
