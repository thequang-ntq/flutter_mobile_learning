import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/providers/selection_provider.dart';

class HomeListTypeRow extends ConsumerWidget {
  final bool typeSelected;
  final Function(String) onTypeButtonPressed;
  final Set<int> selectedTodoIds;

  const HomeListTypeRow({
    super.key,
    required this.typeSelected,
    required this.onTypeButtonPressed,
    required this.selectedTodoIds,
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

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            width * 0.05,
            height * 0.025,
            width * 0.05,
            height * 0.025,
          ),
          child: IgnorePointer(
            ignoring: isSelectionMode,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: width * 0.02,
              children: [
                _buildTypeButton(
                  context,
                  name: "To do",
                  isSelected: !typeSelected,
                  onPressed: onTypeButtonPressed,
                  iconData: Icons.assignment,
                  buttonColor: typeSelected
                      ? colors.outline
                      : colors.primaryContainer,
                  iconColor: typeSelected
                      ? colors.onTertiary
                      : colors.onPrimaryContainer,
                  labelColor: typeSelected
                      ? colors.onTertiary
                      : colors.onPrimaryContainer,
                ),
                _buildTypeButton(
                  context,
                  name: "Done",
                  isSelected: typeSelected,
                  onPressed: onTypeButtonPressed,
                  iconData: Icons.assignment_turned_in,
                  buttonColor: typeSelected
                      ? colors.secondaryContainer
                      : colors.outline,
                  iconColor: typeSelected
                      ? colors.onSecondaryContainer
                      : colors.onTertiary,
                  labelColor: typeSelected
                      ? colors.onSecondaryContainer
                      : colors.onTertiary,
                ),
              ],
            ),
          ),
        ),
        if (isSelectionMode)
          Positioned.fill(
            child: Container(
              color: colors.primaryContainer.withValues(alpha: 0.95),
              child: Center(
                child: Text(
                  "Choosing ${selectedTodoIds.length} ${selectedTodoIds.length > 1 ? "tasks" : "task"}",
                  style: text.titleLarge!.copyWith(
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTypeButton(
    BuildContext context, {
    required String name,
    required bool isSelected,
    required Function(String) onPressed,
    required IconData iconData,
    required Color buttonColor,
    required Color iconColor,
    required Color labelColor,
  }) {
    final text = context.text;

    return FilledButton.icon(
      onPressed: () {
        onPressed(name);
      },
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(buttonColor)),
      icon: Icon(iconData, color: iconColor),
      label: Text(name, style: text.titleLarge!.copyWith(color: labelColor)),
    );
  }
}
