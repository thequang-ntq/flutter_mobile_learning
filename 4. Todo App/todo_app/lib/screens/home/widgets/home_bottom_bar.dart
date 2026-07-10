import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/selection_provider.dart';
import 'package:todo_app/widgets/confirm_dialog.dart';

class HomeBottomBar extends ConsumerWidget {
  final bool typeSelected;
  final Function(String, bool) onConfirmDialogPressed;
  final ValueNotifier<Set<int>> selectedTodoIds;

  const HomeBottomBar({
    super.key,
    required this.typeSelected,
    required this.onConfirmDialogPressed,
    required this.selectedTodoIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isSelectionMode = ref.watch(
      SelectionProvider.isSelectionModeProvider,
    );

    if (!isSelectionMode) return const SizedBox.shrink();

    final firstAction = typeSelected ? "uncheck" : "check";

    return BottomAppBar(
      color: colors.surface,
      child: Row(
        children: [
          if (selectedTodoIds.value.isNotEmpty)
            Expanded(
              child: IconButton(
                onPressed: () => _showConfirmDialog(
                  context,
                  title:
                      "${firstAction[0].toUpperCase() + firstAction.substring(1)} tasks",
                  content: "Are you sure you want to $firstAction these tasks",
                  action: firstAction,
                ),
                icon: typeSelected
                    ? Icon(Icons.remove_done, color: colors.inversePrimary)
                    : Icon(Icons.check, color: colors.secondaryContainer),
              ),
            ),
          if (selectedTodoIds.value.isNotEmpty)
            Expanded(
              child: IconButton(
                onPressed: () => _showConfirmDialog(
                  context,
                  title: "Delete tasks",
                  content: "Are you sure you want to delete these tasks",
                  action: "delete",
                ),
                icon: Icon(Icons.delete, color: colors.error),
              ),
            ),
          Expanded(
            child: IconButton(
              onPressed: () => _onClosePressed(ref),
              icon: Icon(Icons.close, color: colors.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String action,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return ConfirmDialog(
          onConfirmPressed: onConfirmDialogPressed,
          title: title,
          content: content,
          action: action,
          typeSelected: typeSelected,
        );
      },
    );
  }

  void _onClosePressed(WidgetRef ref) {
    ref.read(SelectionProvider.isSelectionModeProvider.notifier).disable();
    selectedTodoIds.value.clear();
  }
}
