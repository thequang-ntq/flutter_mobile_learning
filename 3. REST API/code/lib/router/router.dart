import 'package:code/pages/dio_home_page.dart';
// import 'package:code/pages/http_home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    // Simple state management app
    GoRoute(path: '/', redirect: (context, state) => '/home'),
    // GoRoute(path: '/home', builder: (context, state) => const HttpHomePage()),
    GoRoute(path: '/home', builder: (context, state) => const DioHomePage()),
  ],
);
