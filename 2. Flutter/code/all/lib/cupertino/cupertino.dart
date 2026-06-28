import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCupertino extends StatelessWidget {
  const MyCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody(context));
  }

  // AppBar
  PreferredSizeWidget _buildAppBar() {
    return CupertinoNavigationBar(
      middle: Text('Cupertino Widgets'),
      trailing: CupertinoButton(child: const Icon(Icons.add), onPressed: () {}),
    );
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
              _buildExtendedButton(
                context,
                title: "Extended floating action button",
              ),

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

  Widget _buildButton(BuildContext context, {String? title}) {
    final colors = Theme.of(context).colorScheme;

    return CupertinoButton(
      color: colors.outline,
      onPressed: () {},
      child: Text(title ?? ""),
    );
  }

  // Extended floating action button
  Widget _buildExtendedButton(BuildContext context, {String? title}) {
    final colors = Theme.of(context).colorScheme;

    return CupertinoButton(
      color: colors.outline,
      onPressed: () {},
      child: Text(title ?? ""),
    );
  }

  // Icon Button
  Widget _buildIconButton() {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.info),
      onPressed: () {},
    );
  }
}
