import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/onboarding_slide_model.dart';
import 'package:todo_app/services/onboarding_slide_service.dart';
import 'package:todo_app/widgets/onboarding/animated_move_button.dart';
import 'package:todo_app/widgets/onboarding/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController? _tabController;
  late Future<List<OnboardingSlideModel>> _slides;
  int _totalSlides = 0;
  int _currentPageIndex = 0;

  void _ensureTabController(int length) {
    _totalSlides = length;
    if (_tabController == null || _tabController!.length != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);
    }
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
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colors.primary,
      actions: <Widget>[
        _buildMoveLink(
          context,
          isExisted: true,
          isSkipButton: true,
          name: "Skip",
          backgroundColor: Colors.transparent,
          color: colors.onPrimary,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.1, h * 0.03, w * 0.1, 0),
      child: FutureBuilder<List<OnboardingSlideModel>>(
        future: _slides,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final listSlides = snapshot.data!;
            _ensureTabController(listSlides.length);

            return Stack(
              alignment: AlignmentGeometry.bottomCenter,
              children: <Widget>[
                PageView.builder(
                  controller: _pageViewController,
                  onPageChanged: _handlePageViewChanged,
                  itemCount: listSlides.length,
                  itemBuilder: (context, index) {
                    final slide = listSlides[index];

                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: h * 0.03,
                        children: <Widget>[
                          _buildImage(context, imageUrl: slide.imageUrl),
                          _buildTextContent(
                            context,
                            title: slide.title,
                            detail: slide.detail,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _buildPageIndicator(listSlides.length),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: text.bodyLarge!.copyWith(color: colors.onSurface),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(color: colors.primary),
          );
        }),
      ),
    );
  }

  Widget _buildImage(BuildContext context, {required String imageUrl}) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.fromLTRB(w * 0.07, 0, w * 0.07, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(image: AssetImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTextContent(
    BuildContext context, {
    required String title,
    required String detail,
  }) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final h = MediaQuery.of(context).size.height;

    return Column(
      spacing: h * 0.015,
      children: <Widget>[
        Text(
          title,
          style: text.titleLarge!.copyWith(color: colors.onPrimary),
          textAlign: TextAlign.center,
        ),
        Text(
          detail,
          style: text.bodyLarge!.copyWith(color: colors.onPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPageIndicator(int numberOfSlides) {
    return PageIndicator(
      tabController: _tabController!,
      currentPageIndex: _currentPageIndex,
      onUpdateCurrentPageIndex: _updateCurrentPageIndex,
      numberOfSlides: numberOfSlides,
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final isFirstSlide = (_currentPageIndex == 0);
    final isLastSlide =
        (_totalSlides > 0 && _currentPageIndex == _totalSlides - 1);

    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.03, h * 0.03, w * 0.03, h * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildMoveLink(
            context,
            isExisted: isFirstSlide ? false : true,
            isSkipButton: false,
            name: "Prev",
            backgroundColor: colors.surface,
            color: colors.onSurface,
          ),
          _buildMoveLink(
            context,
            isExisted: true,
            isSkipButton: false,
            name: isLastSlide ? "Let's go" : "Next",
            backgroundColor: colors.surface,
            color: colors.onSurface,
          ),
        ],
      ),
    );
  }

  Widget _buildMoveLink(
    BuildContext context, {
    required bool isExisted,
    required bool isSkipButton,
    required Color backgroundColor,
    required String name,
    required Color color,
  }) {
    final text = Theme.of(context).textTheme;

    return AnimatedMoveButton(
      isVisible: isExisted,
      isSkipButton: isSkipButton,
      onPressed: () {
        _onButtonPressed(context, name: name);
      },
      backgroundColor: backgroundColor,
      name: name,
      textStyle: TextStyle(
        fontSize: text.bodyLarge!.fontSize,
        fontWeight: isSkipButton ? FontWeight.w800 : text.bodyLarge!.fontWeight,
      ),
      color: color,
    );
  }
}
