import 'package:flutter/material.dart';

class AnimatedMoveButton extends StatefulWidget {
  const AnimatedMoveButton({
    super.key,
    required this.isVisible,
    required this.isSkipButton,
    required this.onPressed,
    required this.backgroundColor,
    required this.name,
    required this.textStyle,
    required this.color,
  });

  final bool isVisible;
  final bool isSkipButton;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final String name;
  final TextStyle textStyle;
  final Color color;

  @override
  State<AnimatedMoveButton> createState() => _AnimatedMoveButtonState();
}

class _AnimatedMoveButtonState extends State<AnimatedMoveButton>
    with TickerProviderStateMixin {
  late AnimationController _showHideController;
  late AnimationController _pressController;

  late Animation<double> _showHideScale;
  late Animation<double> _showHideFade;
  late Animation<Offset> _showHideSlide;

  late Animation<double> _pressScale;
  late Animation<double> _pressFade;

  void _onButtonPressed() {
    _pressController.forward().then((_) {
      _pressController.reverse();
    });
    widget.onPressed();
  }

  @override
  void initState() {
    super.initState();

    _showHideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _showHideScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _showHideController, curve: Curves.elasticOut),
    );

    _showHideFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _showHideController, curve: Curves.easeInOut),
    );

    _showHideSlide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _showHideController, curve: Curves.easeInOut),
        );

    _pressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _pressScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );

    _pressFade = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );

    if (widget.isVisible) {
      _showHideController.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedMoveButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        _showHideController.forward();
      } else {
        _showHideController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _showHideController.dispose();
    _pressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _showHideFade,
      child: SlideTransition(
        position: _showHideSlide,
        child: ScaleTransition(
          scale: _showHideScale,
          child: ScaleTransition(
            scale: _pressScale,
            child: FadeTransition(
              opacity: _pressFade,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    widget.isSkipButton
                        ? Colors.transparent
                        : widget.backgroundColor,
                  ),
                  elevation: widget.isSkipButton
                      ? WidgetStatePropertyAll(0)
                      : null,
                ),
                onPressed: _onButtonPressed,
                child: Text(
                  widget.name,
                  style: widget.textStyle.copyWith(color: widget.color),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
