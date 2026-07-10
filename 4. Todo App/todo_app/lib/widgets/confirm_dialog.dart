import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmDialog extends StatelessWidget {
  final Function(String, bool) onConfirmPressed;
  final String title;
  final String content;
  final String action;
  final bool typeSelected;

  const ConfirmDialog({
    super.key,
    required this.onConfirmPressed,
    required this.title,
    required this.content,
    required this.action,
    required this.typeSelected,
  });

  Color _createConfirmColor(ColorScheme colors) {
    return switch (action) {
      "check" => colors.secondaryContainer,
      "uncheck" => colors.inversePrimary,
      "delete" => colors.error,
      _ => colors.onPrimary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final confirmColor = _createConfirmColor(colors);

    return AlertDialog(
      backgroundColor: colors.surface,
      title: Text(
        title,
        style: text.titleLarge!.copyWith(color: colors.onSurface),
      ),
      content: Text(
        content,
        style: text.bodyLarge!.copyWith(color: colors.onSurface),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(
            'Cancel',
            style: text.titleLarge!.copyWith(color: colors.outline),
          ),
        ),
        FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () {
            onConfirmPressed(action, typeSelected);
          },
          child: Text(
            "Confirm $action",
            style: text.titleLarge!.copyWith(color: confirmColor),
          ),
        ),
      ],
    );
  }
}
