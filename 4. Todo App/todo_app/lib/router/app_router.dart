import 'package:go_router/go_router.dart';
import 'package:todo_app/pages/form_page.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/pages/onboarding_page.dart';

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(path: '/', redirect: (context, state) => '/guide'),
      GoRoute(
        path: '/guide',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      GoRoute(path: '/form', builder: (context, state) => const FormPage()),
    ],
  );
}
