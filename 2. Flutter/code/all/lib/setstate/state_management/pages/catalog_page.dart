import 'package:code_learning_flutter/setstate/state_management/widgets/catalog/catalog_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  void _checkCart(BuildContext context) {
    context.push('/cart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody());
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      title: Text("Catalog", style: text.headlineLarge),
      centerTitle: true,
      backgroundColor: colors.primary,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            _checkCart(context);
          },
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return CatalogList(numberOfItem: 20);
  }
}
