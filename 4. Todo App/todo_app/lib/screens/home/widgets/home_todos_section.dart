// lib/screens/home/widgets/home_todos_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/selection_provider.dart';

class HomeTodosSection extends ConsumerWidget {
  final bool typeSelected;
  final Future<List<TodoModel>> todos;
  final Function(int) onCircleButtonPressed;
  final Function(List<TodoModel>) onSelectAllButtonPressed;

  const HomeTodosSection({
    super.key,
    required this.typeSelected,
    required this.todos,
    required this.onCircleButtonPressed,
    required this.onSelectAllButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = context.text;
    final colors = context.colors;
    final width = context.width;
    final height = context.height;

    final isSelectionMode = ref.watch(
      SelectionProvider.isSelectionModeProvider,
    );
    final isSelectionModeNotifier = ref.read(
      SelectionProvider.isSelectionModeProvider.notifier,
    );
    final selectedTodoIds = ref.watch(
      SelectionProvider.selectedTodoIdsProvider,
    );
    final selectedTodoIdsNotifier = ref.read(
      SelectionProvider.selectedTodoIdsProvider.notifier,
    );

    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          width * 0.05,
          height * 0.01,
          width * 0.05,
          height * 0.025,
        ),
        child: FutureBuilder<List<TodoModel>>(
          future: todos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final todoList = snapshot.data!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        final todo = todoList[index];

                        return GestureDetector(
                          onLongPress: () {
                            _onLongPress(
                              isSelectionMode: isSelectionMode,
                              isSelectionModeNotifier: isSelectionModeNotifier,
                              selectedTodoIdsNotifier: selectedTodoIdsNotifier,
                              todo: todo,
                            );
                          },
                          onTap: () {
                            _onTodoPressed(
                              isSelectionMode: isSelectionMode,
                              selectedTodoIdsNotifier: selectedTodoIdsNotifier,
                              todo: todo,
                            );
                          },
                          child: ListTile(
                            leading: typeSelected
                                ? Icon(
                                    Icons.assignment_turned_in,
                                    color: colors.secondaryContainer,
                                  )
                                : Icon(
                                    Icons.assignment,
                                    color: colors.onSurface,
                                  ),
                            title: TextButton(
                              style: const ButtonStyle(
                                alignment: AlignmentGeometry.centerStart,
                              ),
                              onPressed: () {
                                _onTodoPressed(
                                  isSelectionMode: isSelectionMode,
                                  selectedTodoIdsNotifier:
                                      selectedTodoIdsNotifier,
                                  todo: todo,
                                );
                              },
                              child: Text(
                                todo.content,
                                style: text.bodyLarge!.copyWith(
                                  color: colors.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                onCircleButtonPressed(todo.id);
                              },
                              icon: selectedTodoIds.contains(todo.id)
                                  ? Icon(
                                      Icons.check_circle,
                                      color: colors.onPrimaryContainer,
                                    )
                                  : Icon(
                                      Icons.circle_outlined,
                                      color: colors.onSurface,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (isSelectionMode)
                    ElevatedButton(
                      onPressed: () {
                        onSelectAllButtonPressed(todoList);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(colors.primary),
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
                          selectedTodoIds.length == todoList.length
                              ? Icon(Icons.check_box, color: colors.onPrimary)
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  color: colors.onPrimary,
                                ),
                        ],
                      ),
                    ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            return Center(
              child: CircularProgressIndicator(color: colors.onSurface),
            );
          },
        ),
      ),
    );
  }

  void _onLongPress({
    required bool isSelectionMode,
    required IsSelectionModeNotifier isSelectionModeNotifier,
    required SelectedTodoIdsNotifier selectedTodoIdsNotifier,
    required TodoModel todo,
  }) {
    if (!isSelectionMode) {
      isSelectionModeNotifier.enable();
      selectedTodoIdsNotifier.add(todo.id);
    }
  }

  void _onTodoPressed({
    required bool isSelectionMode,
    required SelectedTodoIdsNotifier selectedTodoIdsNotifier,
    required TodoModel todo,
  }) {
    if (isSelectionMode) {
      selectedTodoIdsNotifier.toggle(todo.id);
      return;
    }
  }
}
