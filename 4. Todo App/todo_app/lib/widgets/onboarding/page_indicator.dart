import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.numberOfSlides,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final int numberOfSlides;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TabPageSelector(
      controller: tabController,
      color: colors.surface,
      selectedColor: colors.onSurface,
    );
  }
}
