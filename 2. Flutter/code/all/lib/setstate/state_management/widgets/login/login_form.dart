// import 'package:code_learning_flutter/setstate/state_management/pages/catalog_page.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onSubmit});
  final VoidCallback onSubmit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  bool _obscurePassword = true;

  void _toggledPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: h * 0.03,
        children: <Widget>[
          _buildFormField(
            context,
            fieldName: "username",
            fieldKey: _usernameKey,
            isPassword: false,
          ),
          _buildFormField(
            context,
            fieldName: "password",
            fieldKey: _passwordKey,
            isPassword: true,
          ),
          SizedBox(height: h * 0.01),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(colors.primary),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.fromLTRB(w * 0.07, h * 0.008, w * 0.07, h * 0.008),
              ),
            ),
            onPressed: _submit,
            child: Text("Enter", style: text.headlineSmall),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    BuildContext context, {
    required String fieldName,
    required GlobalKey<FormFieldState> fieldKey,
    required bool isPassword,
  }) {
    final colors = Theme.of(context).colorScheme;

    return TextFormField(
      key: fieldKey,
      cursorColor: colors.tertiary,
      decoration: InputDecoration(
        hintText: "Enter $fieldName",
        hintStyle: TextStyle(color: colors.outline),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.surfaceContainerHighest,
            width: 3,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.primary, width: 3),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colors.error, width: 3),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _toggledPassword,
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $fieldName";
        }
        return null;
      },
      onTap: () {
        fieldKey.currentState!.clearError();
      },
      obscureText: isPassword ? _obscurePassword : false,
    );
  }
}
