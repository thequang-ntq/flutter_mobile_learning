import 'package:flutter/material.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';
import 'onboarding_slide_content.dart';
import '../../../widgets/page_indicator.dart';

class OnboardingBody extends StatelessWidget {
  final PageController pageViewController;
  final TabController? tabController;
  final int currentPageIndex;
  final List<OnboardingSlideModel> slides;
  final Function(int) onPageChanged;
  final Function(int) onUpdateCurrentPageIndex;

  const OnboardingBody({
    super.key,
    required this.pageViewController,
    required this.tabController,
    required this.currentPageIndex,
    required this.slides,
    required this.onPageChanged,
    required this.onUpdateCurrentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final w = context.width;
    final h = context.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(w * 0.1, h * 0.03, w * 0.1, 0),

        child: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            PageView.builder(
              controller: pageViewController,
              onPageChanged: onPageChanged,
              itemCount: slides.length,
              itemBuilder: (context, index) {
                return OnboardingSlideContent(slide: slides[index]);
              },
            ),

            PageIndicator(
              tabController: tabController!,
              currentPageIndex: currentPageIndex,
              onUpdateCurrentPageIndex: (index) {
                onUpdateCurrentPageIndex(index);
              },
              numberOfSlides: slides.length,
            ),
          ],
        ),
      ),
    );
  }
}
