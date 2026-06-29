import 'package:code_learning_flutter/setstate/state_management/widgets/cart/cart_body.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colors.surface,
      title: Text("Cart", style: text.headlineLarge),
      centerTitle: true,
      // backgroundColor: colors.surface,
    );
  }

  Widget _buildBody(BuildContext context) {
    return CartBody();
  }
}
