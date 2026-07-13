import 'package:flutter/material.dart';
import 'package:todo_app/extensions/context_extension.dart';
import '../../../widgets/animated_move_button.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSkipPressed;

  const OnboardingAppBar({super.key, required this.onSkipPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;

    return AppBar(
      backgroundColor: colors.inversePrimary,
      actions: [
        AnimatedMoveButton(
          isVisible: true,
          isSkipButton: true,
          onPressed: onSkipPressed,
          backgroundColor: Colors.transparent,
          name: "Skip",
          textStyle: text.bodyLarge!,
          color: colors.onPrimary,
        ),
      ],
    );
  }
}
