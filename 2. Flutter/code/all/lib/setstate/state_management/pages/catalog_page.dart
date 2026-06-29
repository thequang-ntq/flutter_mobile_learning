// import 'package:code_learning_flutter/setstate/state_management/models/user_model.dart';
import 'package:code_learning_flutter/setstate/state_management/pages/cart_page.dart';
// import 'package:code_learning_flutter/setstate/state_management/pages/login_page.dart';
import 'package:code_learning_flutter/setstate/state_management/widgets/catalog/catalog_list.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  void _checkCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CartPage()),
    );
  }

  // void _logout(BuildContext context, UserModel user) {
  //   Navigator.of(context).pop();
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => const LoginPage()),
  //   );
  //   user.logout();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      // floatingActionButton: _buildButton(context),
    );
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

  // Widget _buildButton(BuildContext context) {
  //   return Consumer<UserModel>(
  //     builder: (context, user, _) {
  //       return FloatingActionButton(
  //         onPressed: () {
  //           _logout(context, user);
  //         },
  //         child: const Icon(Icons.logout),
  //       );
  //     },
  //   );
  // }
}
