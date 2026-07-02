import 'package:go_router/go_router.dart';
import 'package:todo_app/pages/home_page.dart';

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(path: '/', redirect: (context, state) => '/home'),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
  );
}
