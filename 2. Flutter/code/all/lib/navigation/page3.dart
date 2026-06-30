import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  void _navigateBefore(BuildContext context) {
    context.pop();
  }

  void _navigateNext(BuildContext context) {
    context.push("/route2-p3");
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

    return Center(child: Text("Page 3", style: text.headlineSmall));
  }

  Widget _buildFloatingActionButton(BuildContext context) {
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
            _navigateNext(context);
          },
          child: const Icon(Icons.arrow_circle_right),
        ),
      ],
    );
  }
}
