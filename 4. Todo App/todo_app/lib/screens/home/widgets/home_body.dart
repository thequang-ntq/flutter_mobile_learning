import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/home/widgets/home_list_type_row.dart';
import 'package:todo_app/screens/home/widgets/home_search_section.dart';
import 'package:todo_app/screens/home/widgets/home_todos_section.dart';

class HomeBody extends ConsumerWidget {
  final bool typeSelected;
  final bool isSearching, isSearchingCompleted;
  final Future<List<TodoModel>> todos;
  final SearchController searchController, searchControllerCompleted;
  final Function(String) onTypeButtonPressed;
  final Function({
    required String keyword,
    required SearchController controller,
  })
  onSearchButtonPressed;
  final Function(SearchController) onClearSearchButtonPressed;
  final Function(int) onCircleButtonPressed;
  final Function(List<TodoModel>) onSelectAllButtonPressed;

  const HomeBody({
    super.key,
    required this.typeSelected,
    required this.isSearching,
    required this.isSearchingCompleted,
    required this.todos,
    required this.searchController,
    required this.searchControllerCompleted,
    required this.onTypeButtonPressed,
    required this.onSearchButtonPressed,
    required this.onClearSearchButtonPressed,
    required this.onCircleButtonPressed,
    required this.onSelectAllButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        children: [
          HomeListTypeRow(
            typeSelected: typeSelected,
            onTypeButtonPressed: onTypeButtonPressed,
          ),
          HomeSearchSection(
            typeSelected: typeSelected,
            isSearching: isSearching,
            isSearchingCompleted: isSearchingCompleted,
            searchController: searchController,
            searchControllerCompleted: searchControllerCompleted,
            onSearchButtonPressed: onSearchButtonPressed,
            onClearSearchButtonPressed: onClearSearchButtonPressed,
          ),
          HomeTodosSection(
            typeSelected: typeSelected,
            todos: todos,
            onCircleButtonPressed: onCircleButtonPressed,
            onSelectAllButtonPressed: onSelectAllButtonPressed,
          ),
        ],
      ),
    );
  }
}
