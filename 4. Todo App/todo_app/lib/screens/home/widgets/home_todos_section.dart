import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/selection_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';

class HomeTodosSection extends ConsumerWidget {
  final bool typeSelected;
  final bool isSearching, isSearchingCompleted;
  final Function(int) onCircleButtonPressed;
  final Function(List<TodoModel>) onSelectAllButtonPressed;
  final ValueNotifier<Set<int>> selectedTodoIds;

  const HomeTodosSection({
    super.key,
    required this.typeSelected,
    required this.isSearching,
    required this.isSearchingCompleted,
    required this.onCircleButtonPressed,
    required this.onSelectAllButtonPressed,
    required this.selectedTodoIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = context.text;
    final colors = context.colors;
    final width = context.width;
    final height = context.height;

    final todos = ref.watch(TodoProvider.todosProvider(typeSelected));
    final todoListOther =
        ref.watch(TodoProvider.todosProvider(!typeSelected)).value ?? [];

    final isSelectionMode = ref.watch(
      SelectionProvider.isSelectionModeProvider,
    );

    final highlightId = ref.watch(TodoProvider.highlightedTodoIdsProvider);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          width * 0.05,
          height * 0.01,
          width * 0.05,
          height * 0.025,
        ),
        child: todos.when(
          data: (todos) {
            return todos.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];

                            return GestureDetector(
                              onLongPress: () {
                                _onLongPress(ref: ref, todo: todo);
                              },
                              onTap: () {
                                _onTodoPressed(context, ref: ref, todo: todo);
                              },
                              child: ListTile(
                                tileColor: highlightId.contains(todo.id)
                                    ? colors.primary
                                    : null,
                                leading: typeSelected
                                    ? Icon(
                                        Icons.assignment_turned_in,
                                        color: colors.secondaryContainer,
                                      )
                                    : Icon(
                                        Icons.assignment,
                                        color: highlightId.contains(todo.id)
                                            ? colors.onPrimary
                                            : colors.onSurface,
                                      ),
                                title: TextButton(
                                  style: const ButtonStyle(
                                    alignment: AlignmentGeometry.centerStart,
                                  ),
                                  onPressed: () {
                                    _onTodoPressed(
                                      context,
                                      ref: ref,
                                      todo: todo,
                                    );
                                  },
                                  child: Text(
                                    todo.content,
                                    style: text.bodyLarge!.copyWith(
                                      color: highlightId.contains(todo.id)
                                          ? colors.onPrimary
                                          : colors.onSurface,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    onCircleButtonPressed(todo.id);
                                  },
                                  icon: selectedTodoIds.value.contains(todo.id)
                                      ? Icon(
                                          Icons.check_circle,
                                          color: colors.onPrimaryContainer,
                                        )
                                      : Icon(
                                          Icons.circle_outlined,
                                          color: highlightId.contains(todo.id)
                                              ? colors.onPrimary
                                              : colors.onSurface,
                                        ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: height * 0.015);
                          },
                        ),
                      ),
                      if (isSelectionMode)
                        ElevatedButton(
                          onPressed: () {
                            onSelectAllButtonPressed(todos);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              colors.primary,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select all',
                                style: text.titleLarge!.copyWith(
                                  color: colors.onPrimary,
                                ),
                              ),
                              selectedTodoIds.value.length == todos.length
                                  ? Icon(
                                      Icons.check_box,
                                      color: colors.onPrimary,
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      color: colors.onPrimary,
                                    ),
                            ],
                          ),
                        ),
                    ],
                  )
                : _buildEmptyText(
                    context,
                    todoList: todos,
                    todoListOther: todoListOther,
                  );
          },

          error: (error, stackTrace) {
            return Center(
              child: Text(
                "Error: $error",
                style: text.titleLarge!.copyWith(color: colors.error),
                textAlign: TextAlign.center,
              ),
            );
          },

          loading: () {
            return Center(
              child: CircularProgressIndicator(color: colors.onSurface),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyText(
    BuildContext context, {
    required List<TodoModel> todoList,
    required List<TodoModel> todoListOther,
  }) {
    final text = context.text;
    final colors = context.colors;
    final width = context.width;

    late String emptyContent;
    late Color emptyContentColor;

    if (!typeSelected) {
      if (!isSearching) {
        if (todoListOther.isEmpty) {
          emptyContent =
              "Let's create some todo tasks by clicking the [+] button at the bottom of the app";
          emptyContentColor = colors.primary;
        } else {
          emptyContent = "Congratulations! You have completed all todo tasks!";
          emptyContentColor = colors.onSecondaryContainer;
        }
      } else {
        emptyContent = "Cannot find any task related to the search condition";
        emptyContentColor = colors.onSurface;
      }
    } else {
      if (!isSearchingCompleted) {
        if (todoListOther.isEmpty) {
          emptyContent = "Let's create some todo tasks to complete them";
          emptyContentColor = colors.primary;
        } else {
          emptyContent = "Maybe it's the time to complete some todo tasks.";
          emptyContentColor = colors.onSurface;
        }
      } else {
        emptyContent =
            "Cannot find any completed task related to the search condition";
        emptyContentColor = colors.onSurface;
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
      child: Center(
        child: Text(
          emptyContent,
          style: text.titleLarge!.copyWith(color: emptyContentColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onLongPress({required WidgetRef ref, required TodoModel todo}) {
    final isSelectionMode = ref.watch(
      SelectionProvider.isSelectionModeProvider,
    );
    final isSelectionModeNotifier = ref.read(
      SelectionProvider.isSelectionModeProvider.notifier,
    );

    final currentIds = Set<int>.from(selectedTodoIds.value);

    if (!isSelectionMode) {
      isSelectionModeNotifier.enable();
      currentIds.add(todo.id);
      selectedTodoIds.value = currentIds;
    }
  }

  // Handle when press todo -> check mode: add/remove check ids. todo (not done) -> change to form page to edit
  void _onTodoPressed(
    BuildContext context, {
    required WidgetRef ref,
    required TodoModel todo,
  }) {
    final isSelectionMode = ref.watch(
      SelectionProvider.isSelectionModeProvider,
    );

    final editingTodoIdNotifier = ref.read(
      TodoProvider.editingTodoIdProvider.notifier,
    );

    final currentIds = Set<int>.from(selectedTodoIds.value);

    if (isSelectionMode) {
      if (currentIds.contains(todo.id)) {
        currentIds.remove(todo.id);
      } else {
        currentIds.add(todo.id);
      }
      selectedTodoIds.value = currentIds;

      return;
    }

    if (typeSelected) return;

    editingTodoIdNotifier.state = todo.id;
    context.go('/form');
  }
}
