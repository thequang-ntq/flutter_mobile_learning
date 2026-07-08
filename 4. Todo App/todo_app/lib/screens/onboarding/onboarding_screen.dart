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
  late Future<List<OnboardingSlideModel>> _slides;
  int _totalSlides = 0;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 0, vsync: this);
    _slides = OnboardingSlideService.getAll();
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
        totalSlides: _totalSlides,
        slides: _slides,
        onPageChanged: _handlePageViewChanged,
        onEnsureTabController: _ensureTabController,
        onUpdateCurrentPageIndex: _updateCurrentPageIndex,
      ),
      bottomNavigationBar: OnboardingBottomBar(
        currentPageIndex: _currentPageIndex,
        totalSlides: _totalSlides,
        onPrevPressed: () => _onButtonPressed(context, name: "Prev"),
        onNextPressed: () => _onButtonPressed(
          context,
          name: _currentPageIndex == _totalSlides - 1 ? "Let's go" : "Next",
        ),
      ),
    );
  }

  void _ensureTabController(int length) {
    _totalSlides = length;
    if (_tabController == null || _tabController!.length != length) {
      _tabController?.dispose();
      setState(() {
        _tabController = TabController(length: length, vsync: this);
      });
    }
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController!.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController!.index = index;
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
