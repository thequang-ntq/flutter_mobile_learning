import 'package:code_learning_flutter/setstate/state_management/pages/cart_page.dart';
import 'package:code_learning_flutter/setstate/state_management/pages/catalog_page.dart';
import 'package:code_learning_flutter/setstate/state_management/pages/login_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    // Simple state management app
    GoRoute(path: '/', redirect: (context, state) => '/login'),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/catalog', builder: (context, state) => const CatalogPage()),
    GoRoute(path: '/cart', builder: (context, state) => const CartPage()),

    // Navigation
    /*
    GoRoute(path: '/', redirect: (context, state) => '/route1'),
    GoRoute(path: '/route1', builder: (context, state) => const Page1()),
    GoRoute(path: '/route2-p1', builder: (context, state) => const Page2()),
    GoRoute(path: '/route2-p2', builder: (context, state) => const Page3()),
    GoRoute(path: '/route2-p3', builder: (context, state) => const Page4()),
    */

    // TextField, TextEditingController, Form, GlobalKey, Validator
    // GoRoute(path: '/', redirect: (context, state) => '/login'),
    // GoRoute(path: '/login', builder: (context, state) => const CustomForm()),
  ],
);
