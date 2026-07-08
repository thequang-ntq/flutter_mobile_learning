import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/selection_provider.dart';
import 'package:todo_app/screens/home/widgets/home_body.dart';
import 'package:todo_app/screens/home/widgets/home_bottom_bar.dart';
import 'package:todo_app/services/todo_service.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<TodoModel>> _todos, _todosCompleted;
  late SearchController _searchController, _searchControllerCompleted;
  bool _typeSelected = false;
  bool _isSearching = false, _isSearchingCompleted = false;

  @override
  void initState() {
    super.initState();
    _loadTodos();
    _searchController = SearchController();
    _searchControllerCompleted = SearchController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchControllerCompleted.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosSelected = _typeSelected ? _todosCompleted : _todos;

    return Scaffold(
      body: HomeBody(
        typeSelected: _typeSelected,
        isSearching: _isSearching,
        isSearchingCompleted: _isSearchingCompleted,
        todos: todosSelected,
        searchController: _searchController,
        searchControllerCompleted: _searchControllerCompleted,
        onTypeButtonPressed: _onTypeButtonPressed,
        onSearchButtonPressed: _onSearchButtonPressed,
        onClearSearchButtonPressed: _onClearSearchButtonPressed,
        onCircleButtonPressed: _onCircleButtonPressed,
        onSelectAllButtonPressed: _onSelectAllButtonPressed,
      ),
      bottomNavigationBar: HomeBottomBar(
        typeSelected: _typeSelected,
        onConfirmDialogPressed: _onConfirmDialogPressed,
      ),
    );
  }

  void _loadTodos() {
    _todos = TodoService.getByStatus(false);
    _todosCompleted = TodoService.getByStatus(true);
  }

  void _onTypeButtonPressed(String name) {
    if ((!_typeSelected && name == "Done") ||
        (_typeSelected && name == "To do")) {
      setState(() {
        _typeSelected = !_typeSelected;
      });
    }
  }

  void _onSearchButtonPressed({
    required String keyword,
    required SearchController controller,
  }) {
    controller.closeView(keyword);

    if (keyword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a keyword')));
      return;
    }

    setState(() {
      if (_typeSelected) {
        _todosCompleted = TodoService.search(
          keyword: keyword,
          isCompleted: true,
        );
        _isSearchingCompleted = true;
      } else {
        _todos = TodoService.search(keyword: keyword, isCompleted: false);
        _isSearching = true;
      }
    });
  }

  void _onClearSearchButtonPressed(SearchController controller) {
    controller.clear();
    setState(() {
      if (_typeSelected) {
        _todosCompleted = TodoService.getByStatus(true);
        _isSearchingCompleted = false;
      } else {
        _todos = TodoService.getByStatus(false);
        _isSearching = false;
      }
    });
  }

  void _onCircleButtonPressed(int todoId) {
    if (!ref.read(SelectionProvider.isSelectionModeProvider)) {
      ref.read(SelectionProvider.isSelectionModeProvider.notifier).enable();
    }

    final selectedTodoIdsNotifier = ref.read(
      SelectionProvider.selectedTodoIdsProvider.notifier,
    );

    if (selectedTodoIdsNotifier.contains(todoId)) {
      selectedTodoIdsNotifier.remove(todoId);
    } else {
      selectedTodoIdsNotifier.add(todoId);
    }
  }

  void _onSelectAllButtonPressed(List<TodoModel> todos) {
    final selectedTodoIdsNotifier = ref.read(
      SelectionProvider.selectedTodoIdsProvider.notifier,
    );

    if (selectedTodoIdsNotifier.length() == todos.length) {
      selectedTodoIdsNotifier.clear();
    } else {
      selectedTodoIdsNotifier.selectAll(todos.map((e) => e.id));
    }
  }

  void _onConfirmDialogPressed(String action) {
    final selectedTodoIds = ref.watch(
      SelectionProvider.selectedTodoIdsProvider,
    );

    switch (action) {
      case "check":
        for (final item in selectedTodoIds) {
          TodoService.setStatus(id: item, setCompleted: true);
        }
      case "uncheck":
        for (final item in selectedTodoIds) {
          TodoService.setStatus(id: item, setCompleted: false);
        }
      case "delete":
        for (final item in selectedTodoIds) {
          TodoService.delete(item);
        }
    }

    ref.read(SelectionProvider.selectedTodoIdsProvider.notifier).clear();
    context.pop();
    ref.read(SelectionProvider.isSelectionModeProvider.notifier).disable();
  }
}
