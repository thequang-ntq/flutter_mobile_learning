import 'package:code_learning_flutter/setstate/state_management/widgets/my_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final text = Theme.of(context).textTheme;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(w * 0.15, 0, w * 0.15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome", style: text.headlineLarge),
            SizedBox(height: h * 0.05),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return MyForm(width: w, height: h);
  }
}
