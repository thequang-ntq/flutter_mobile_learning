import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  void _navigate(BuildContext context) {
    context.push("/route2-p2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return AppBar(
      backgroundColor: colors.primary,
      centerTitle: true,
      title: Text("Route 2", style: text.headlineSmall),
    );
  }

  Widget _buildBody(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Center(child: Text("Page 2", style: text.headlineSmall));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _navigate(context);
      },
      child: const Icon(Icons.arrow_circle_right),
    );
  }
}
