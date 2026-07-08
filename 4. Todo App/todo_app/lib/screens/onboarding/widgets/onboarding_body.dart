import 'package:flutter/material.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';
import 'onboarding_slide_content.dart';
import '../../../widgets/page_indicator.dart';

class OnboardingBody extends StatelessWidget {
  final PageController pageViewController;
  final TabController? tabController;
  final int currentPageIndex;
  final int totalSlides;
  final Future<List<OnboardingSlideModel>> slides;
  final Function(int) onPageChanged;
  final Function(int) onEnsureTabController;
  final Function(int) onUpdateCurrentPageIndex;

  const OnboardingBody({
    super.key,
    required this.pageViewController,
    required this.tabController,
    required this.currentPageIndex,
    required this.totalSlides,
    required this.slides,
    required this.onPageChanged,
    required this.onEnsureTabController,
    required this.onUpdateCurrentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final colors = context.colors;
    final w = context.width;
    final h = context.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(w * 0.1, h * 0.03, w * 0.1, 0),
        child: FutureBuilder<List<OnboardingSlideModel>>(
          future: slides,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listSlides = snapshot.data!;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                onEnsureTabController(listSlides.length);
              });

              return Stack(
                alignment: AlignmentGeometry.bottomCenter,
                children: [
                  PageView.builder(
                    controller: pageViewController,
                    onPageChanged: onPageChanged,
                    itemCount: listSlides.length,
                    itemBuilder: (context, index) {
                      return OnboardingSlideContent(slide: listSlides[index]);
                    },
                  ),

                  PageIndicator(
                    tabController: tabController!,
                    currentPageIndex: currentPageIndex,
                    onUpdateCurrentPageIndex: (index) {
                      onUpdateCurrentPageIndex(index);
                    },
                    numberOfSlides: listSlides.length,
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: text.titleLarge!.copyWith(color: colors.onPrimary),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(color: colors.onPrimary),
            );
          },
        ),
      ),
    );
  }
}
