import 'dart:collection';

import 'package:code_learning_flutter/setstate/state_management/models/cart_model.dart';
import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:code_learning_flutter/setstate/state_management/widgets/cart/cart_list.dart';
import 'package:code_learning_flutter/setstate/state_management/widgets/cart/cart_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Consumer<CartModel>(
      builder: (context, cart, _) {
        final items = cart.items;
        final totalPrice = cart.totalPrice;

        if (items.isEmpty) {
          return Center(
            child: Text("Your cart is empty", style: text.headlineSmall),
          );
        }

        return Column(
          children: <Widget>[
            _buildList(context, items: items),
            Divider(
              color: colors.onPrimary,
              thickness: 6,
              indent: 0,
              endIndent: 0,
            ),
            _buildPayment(cart: cart, totalPrice: totalPrice),
          ],
        );
      },
    );
  }

  Widget _buildList(
    BuildContext context, {
    required UnmodifiableListView<ItemModel> items,
  }) {
    return CartList(items: items);
  }

  Widget _buildPayment({required CartModel cart, required int totalPrice}) {
    return CartPayment(cart: cart, totalPrice: totalPrice);
  }
}
