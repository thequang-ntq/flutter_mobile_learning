import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  bool _obscurePassword = true;

  void _toggledPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _entered() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Processing data")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildFormField(
            context,
            fieldName: "username",
            fieldKey: _usernameKey,
            isPassword: false,
          ),
          SizedBox(height: widget.height * 0.03),
          _buildFormField(
            context,
            fieldName: "password",
            fieldKey: _passwordKey,
            isPassword: true,
          ),
          SizedBox(height: widget.height * 0.04),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(colors.primary),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              padding: WidgetStatePropertyAll(
                EdgeInsets.fromLTRB(
                  widget.width * 0.07,
                  widget.height * 0.008,
                  widget.width * 0.07,
                  widget.height * 0.008,
                ),
              ),
            ),
            onPressed: _entered,
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
