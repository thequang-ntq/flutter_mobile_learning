import 'package:code_learning_flutter/setstate/state_management/widgets/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _submit(BuildContext context) {
    context.go('/catalog');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

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
    return LoginForm(
      onSubmit: () {
        _submit(context);
      },
    );
  }
}
