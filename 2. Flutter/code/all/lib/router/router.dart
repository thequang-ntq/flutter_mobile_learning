import 'package:code_learning_flutter/setstate/state_management/pages/cart_page.dart';
import 'package:code_learning_flutter/setstate/state_management/pages/catalog_page.dart';
import 'package:code_learning_flutter/setstate/state_management/pages/login_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/login'),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/catalog', builder: (context, state) => const CatalogPage()),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
  ],
);
