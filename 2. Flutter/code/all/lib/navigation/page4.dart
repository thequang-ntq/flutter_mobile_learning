import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  void _navigateBefore(BuildContext context) {
    context.pop();
  }

  void _navigate(BuildContext context) {
    context.go("/route1");
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

    return Center(child: Text("Page 4", style: text.headlineSmall));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FloatingActionButton(
          heroTag: 'left',
          onPressed: () {
            _navigateBefore(context);
          },
          child: const Icon(Icons.arrow_circle_left),
        ),
        FloatingActionButton(
          heroTag: 'right',
          onPressed: () {
            _navigate(context);
          },
          child: Text("R1", style: text.labelLarge),
        ),
      ],
    );
  }
}
