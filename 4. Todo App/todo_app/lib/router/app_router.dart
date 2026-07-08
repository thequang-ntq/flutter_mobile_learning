import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/form/form_screen.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/onboarding/onboarding_screen.dart';
import 'package:todo_app/screens/shell_screen.dart';

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: '/guide',
    routes: [
      GoRoute(
        path: '/guide',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/form',
                builder: (context, state) => const FormScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
