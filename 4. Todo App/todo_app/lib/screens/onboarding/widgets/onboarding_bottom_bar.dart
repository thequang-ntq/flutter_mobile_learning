import 'package:flutter/material.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/widgets/animated_move_button.dart';

class OnboardingBottomBar extends StatelessWidget {
  final int currentPageIndex;
  final int totalSlides;
  final VoidCallback onPrevPressed;
  final VoidCallback onNextPressed;

  const OnboardingBottomBar({
    super.key,
    required this.currentPageIndex,
    required this.totalSlides,
    required this.onPrevPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    final w = context.width;
    final h = context.height;

    final isFirstSlide = currentPageIndex == 0;
    final isLastSlide = totalSlides > 0 && currentPageIndex == totalSlides - 1;

    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.03, h * 0.03, w * 0.03, h * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedMoveButton(
            isVisible: !isFirstSlide,
            isSkipButton: false,
            onPressed: onPrevPressed,
            backgroundColor: colors.surface,
            name: "Prev",
            textStyle: text.labelLarge!,
            color: colors.onSurface,
          ),
          AnimatedMoveButton(
            isVisible: true,
            isSkipButton: false,
            onPressed: onNextPressed,
            backgroundColor: colors.surface,
            name: isLastSlide ? "Let's go" : "Next",
            textStyle: text.labelLarge!,
            color: colors.onSurface,
          ),
        ],
      ),
    );
  }
}
