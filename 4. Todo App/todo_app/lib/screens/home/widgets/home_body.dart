import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/toast_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/home/widgets/home_list_type_row.dart';
import 'package:todo_app/screens/home/widgets/home_search_section.dart';
import 'package:todo_app/screens/home/widgets/home_todos_section.dart';
import 'package:todo_app/utils/toast_notification.dart';

class HomeBody extends ConsumerStatefulWidget {
  final bool typeSelected;
  final Function(String) onTypeButtonPressed;
  final Function(int) onCircleButtonPressed;
  final Function(List<TodoModel>) onSelectAllButtonPressed;
  final ValueNotifier<Set<int>> selectedTodoIds;

  const HomeBody({
    super.key,
    required this.typeSelected,
    required this.onTypeButtonPressed,
    required this.onCircleButtonPressed,
    required this.onSelectAllButtonPressed,
    required this.selectedTodoIds,
  });

  @override
  ConsumerState<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends ConsumerState<HomeBody> {
  late SearchController _searchController, _searchControllerCompleted;
  bool _isSearching = false, _isSearchingCompleted = false;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
    _searchControllerCompleted = SearchController();
    _getCurrentSearchStateAfterForm();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchControllerCompleted.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<Set<int>>(
        valueListenable: widget.selectedTodoIds,
        builder: (BuildContext context, Set<int> value, Widget? child) {
          return Column(
            children: [
              HomeListTypeRow(
                typeSelected: widget.typeSelected,
                onTypeButtonPressed: widget.onTypeButtonPressed,
                selectedTodoIds: widget.selectedTodoIds.value,
              ),
              HomeSearchSection(
                typeSelected: widget.typeSelected,
                isSearching: _isSearching,
                isSearchingCompleted: _isSearchingCompleted,
                searchController: _searchController,
                searchControllerCompleted: _searchControllerCompleted,
                onSearchButtonPressed: _onSearchButtonPressed,
                onClearSearchButtonPressed: _onClearSearchButtonPressed,
              ),
              HomeTodosSection(
                typeSelected: widget.typeSelected,
                isSearching: _isSearching,
                isSearchingCompleted: _isSearchingCompleted,
                onCircleButtonPressed: widget.onCircleButtonPressed,
                onSelectAllButtonPressed: widget.onSelectAllButtonPressed,
                selectedTodoIds: widget.selectedTodoIds,
              ),
            ],
          );
        },
      ),
    );
  }

  // Search tasks
  void _onSearchButtonPressed({
    required String keyword,
    required SearchController controller,
  }) {
    controller.closeView(keyword);

    if (keyword.isEmpty) {
      ToastNotification.showInfo(context, message: "Please enter a keyword");
      return;
    }

    ref
        .read(TodoProvider.todosProvider(widget.typeSelected).notifier)
        .search(keyword: keyword, isCompleted: widget.typeSelected);

    setState(() {
      widget.typeSelected ? _isSearchingCompleted = true : _isSearching = true;
    });
  }

  // Clear search state (back to all tasks)
  void _onClearSearchButtonPressed(SearchController controller) async {
    controller.clear();

    ref
        .read(TodoProvider.todosProvider(widget.typeSelected).notifier)
        .clearSearch();

    await ref
        .read(TodoProvider.todosProvider(widget.typeSelected).notifier)
        .refresh();

    setState(() {
      widget.typeSelected
          ? _isSearchingCompleted = false
          : _isSearching = false;
    });
  }

  void _getCurrentSearchStateAfterForm() {
    // Search when from FormPage to HomePage after add/edit, and searched before add/edit
    ref.listenManual<bool>(ToastProvider.isFromFormPageProvider, (
      previous,
      next,
    ) {
      if (!next) return;

      ref
          .read(TodoProvider.todosProvider(widget.typeSelected).notifier)
          .refresh();

      ref.read(ToastProvider.isFromFormPageProvider.notifier).state = false;
    });
  }
}
