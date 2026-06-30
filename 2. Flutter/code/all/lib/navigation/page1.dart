import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  void _navigate(BuildContext context) {
    context.go("/route2-p1");
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
      title: Text("Route 1", style: text.headlineSmall),
    );
  }

  Widget _buildBody(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Center(child: Text("Page 1", style: text.headlineSmall));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return FloatingActionButton(
      onPressed: () {
        _navigate(context);
      },
      child: Text("R2", style: text.labelMedium),
    );
  }
}
