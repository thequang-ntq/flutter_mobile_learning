import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late FocusNode _usernameFocusNode;
  late FocusNode _passwordFocusNode;
  bool _obscurePassword = true;

  void _toggledPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Processing Data')));
    }
  }

  void _showCurrentValue(BuildContext context) {
    final text = Theme.of(context).textTheme;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Username / Password", style: text.headlineMedium),
          content: SingleChildScrollView(
            child: Text(
              (_usernameController.text.isEmpty &&
                      _passwordController.text.isEmpty)
                  ? "[Please enter username & password]"
                  : "${_usernameController.text} / ${_passwordController.text}",
              style: text.headlineSmall,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text("Close", style: text.labelLarge),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
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
            fieldController: _usernameController,
            fieldFocusNode: _usernameFocusNode,
            isPassword: false,
            isAutoFocus: true,
          ),
          _buildFormField(
            context,
            fieldName: "password",
            fieldKey: _passwordKey,
            fieldController: _passwordController,
            fieldFocusNode: _passwordFocusNode,
            isPassword: true,
            isAutoFocus: false,
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
            onPressed: () {
              _submit(context);
            },
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
    required TextEditingController fieldController,
    required FocusNode fieldFocusNode,
    required bool isPassword,
    required bool isAutoFocus,
  }) {
    final colors = Theme.of(context).colorScheme;

    return TextFormField(
      key: fieldKey,
      controller: fieldController,
      focusNode: fieldFocusNode,
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
          fieldFocusNode.requestFocus();
          return "Please enter $fieldName";
        }
        return null;
      },
      onTap: () {
        fieldKey.currentState!.clearError();
      },
      onChanged: (_) {
        fieldKey.currentState!.clearError();
      },
      obscureText: isPassword ? _obscurePassword : false,
      autofocus: isAutoFocus,
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showCurrentValue(context);
      },
      tooltip: 'Show me the value!',
      child: const Icon(Icons.point_of_sale),
    );
  }
}
