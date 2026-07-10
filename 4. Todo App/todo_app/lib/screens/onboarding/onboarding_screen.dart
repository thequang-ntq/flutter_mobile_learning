import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';
import 'package:todo_app/screens/onboarding/widgets/onboarding_app_bar.dart';
import 'package:todo_app/screens/onboarding/widgets/onboarding_body.dart';
import 'package:todo_app/screens/onboarding/widgets/onboarding_bottom_bar.dart';
import 'package:todo_app/services/onboarding_slide_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController? _tabController;
  late List<OnboardingSlideModel> _slides;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _slides = OnboardingSlideService.getAll();
    _pageViewController = PageController();
    _tabController = TabController(length: _slides.length, vsync: this);
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: OnboardingAppBar(
        onSkipPressed: () => _onButtonPressed(context, name: "Skip"),
      ),
      body: OnboardingBody(
        pageViewController: _pageViewController,
        tabController: _tabController,
        currentPageIndex: _currentPageIndex,
        slides: _slides,
        onPageChanged: _handlePageViewChanged,
        onUpdateCurrentPageIndex: _updateCurrentPageIndex,
      ),
      bottomNavigationBar: OnboardingBottomBar(
        currentPageIndex: _currentPageIndex,
        totalSlides: _slides.length,
        onPrevPressed: () => _onButtonPressed(context, name: "Prev"),
        onNextPressed: () => _onButtonPressed(
          context,
          name: _currentPageIndex == _slides.length - 1 ? "Let's go" : "Next",
        ),
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController?.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController?.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onButtonPressed(BuildContext context, {required String name}) {
    if (name == "Let's go" || name == "Skip") {
      context.go("/home");
      return;
    }

    _currentPageIndex += name == "Next" ? 1 : -1;
    _handlePageViewChanged(_currentPageIndex);
    _updateCurrentPageIndex(_currentPageIndex);
  }
}
