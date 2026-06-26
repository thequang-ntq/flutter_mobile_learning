import 'package:flutter/material.dart';

class MyMaterial extends StatelessWidget {
  const MyMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  // AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: Text('Material Widgets'));
  }

  // Body
  Widget _buildBody(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    // double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, h * 0.1, 0, h * 0.1),
        child: Center(
          child: Column(
            children: <Widget>[
              // ===
              // Actions
              // ===
              Text("Actions:", style: text.bodyLarge),

              SizedBox(height: h * 0.015),

              Text("Button Style", style: text.bodyMedium),
              SizedBox(height: h * 0.005),
              _buildButton(context, title: "Button Style"),

              SizedBox(height: h * 0.01),

              Text("Extended Floating Action Button", style: text.bodyMedium),
              SizedBox(height: h * 0.005),
              _buildExtendedButton(title: "Extended floating action button"),

              SizedBox(height: h * 0.01),

              Text("Icon Button", style: text.bodyMedium),
              SizedBox(height: h * 0.005),
              _buildIconButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Common Button
  Widget _buildButton(BuildContext context, {String? title}) {
    final colors = Theme.of(context).colorScheme;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return colors.primary.withValues(alpha: 0.5);
          }
          return null;
        }),
      ),
      onPressed: () {},
      child: Text(title ?? ""),
    );
  }

  // Extended floating action button
  Widget _buildExtendedButton({String? title}) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: Text(title ?? ""),
    );
  }

  // Icon Button
  Widget _buildIconButton() {
    return IconButton(onPressed: () {}, icon: Icon(Icons.image));
  }

  // Floating Button
  Widget _buildFloatingActionButton() {
    return FloatingActionButton(onPressed: () {}, child: Icon(Icons.add));
  }
}
