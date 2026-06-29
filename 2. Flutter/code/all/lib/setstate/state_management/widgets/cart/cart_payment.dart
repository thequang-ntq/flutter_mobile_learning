import 'package:code_learning_flutter/setstate/state_management/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartPayment extends StatelessWidget {
  const CartPayment({super.key, required this.cart, required this.totalPrice});
  final CartModel cart;
  final int totalPrice;

  void _buyCart(BuildContext context, CartModel cart) {
    cart.removeAll();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: w * 0.1,
      children: <Widget>[
        Text("\$$totalPrice", style: text.headlineLarge),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(colors.surface),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            padding: WidgetStatePropertyAll(
              EdgeInsets.fromLTRB(w * 0.05, h * 0.005, w * 0.05, h * 0.005),
            ),
          ),
          onPressed: () {
            _buyCart(context, cart);
          },
          child: Text(
            "Buy",
            style: TextStyle(
              fontSize: text.labelLarge!.fontSize,
              color: colors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
