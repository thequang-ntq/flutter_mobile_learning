import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/form/widgets/form_body.dart';
import 'package:todo_app/services/todo_service.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<FormFieldState> _contentFieldKey;
  late TextEditingController _contentFieldController;
  late Future<TodoModel> editTodo;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _contentFieldKey = GlobalKey<FormFieldState>();
    _contentFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _contentFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: FormBody(
        formKey: _formKey,
        contentFieldKey: _contentFieldKey,
        contentFieldController: _contentFieldController,
      ),
    );
  }

  void _onFormButtonPressed(
    GlobalKey<FormState> formKey,
    TextEditingController contentFieldController,
  ) {
    if (!formKey.currentState!.validate()) return;
    TodoService.add(contentFieldController.text.trim());
  }
}
