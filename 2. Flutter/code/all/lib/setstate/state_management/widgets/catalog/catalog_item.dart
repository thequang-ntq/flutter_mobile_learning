import 'package:code_learning_flutter/setstate/state_management/models/cart_model.dart';
import 'package:code_learning_flutter/setstate/state_management/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({super.key, required this.position, required this.item});
  final int position;
  final ItemModel item;

  void _addItemToCart({
    required CartModel cart,
    required bool isInCart,
    required ItemModel item,
  }) {
    if (isInCart) {
      cart.remove(item);
    } else {
      cart.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      key: Key(item.id),
      leading: Container(color: item.color, width: w * 0.12, height: h * 0.07),
      title: Text(item.name, style: text.headlineSmall),
      trailing: Consumer<CartModel>(
        builder: (context, cart, _) {
          final isInCart = cart.isInCart(item);

          return ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(colors.surface),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide.none,
                ),
              ),
              elevation: const WidgetStatePropertyAll(0),
              overlayColor: WidgetStatePropertyAll(colors.primary),
            ),
            onPressed: () {
              _addItemToCart(cart: cart, isInCart: isInCart, item: item);
            },
            child: Text(
              isInCart ? "✓" : "ADD",
              style: TextStyle(
                fontSize: text.labelLarge!.fontSize,
                fontWeight: text.labelLarge!.fontWeight,
                color: colors.outline,
              ),
            ),
          );
        },
      ),
    );
  }
}
