import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/selection_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/form/widgets/form_body.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<FormFieldState> _contentFieldKey;
  late TextEditingController _contentFieldController;
  TodoModel? _editTodo;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _contentFieldKey = GlobalKey<FormFieldState>();
    _contentFieldController = TextEditingController();
    _loadTodo();
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
        editTodo: _editTodo,
        onFormButtonPressed: _onFormButtonPressed,
      ),
    );
  }

  Future<void> _loadTodo() async {
    final editingTodoId = ref.read(TodoProvider.editingTodoIdProvider);

    if (editingTodoId == null) return;

    _editTodo = await ref
        .read(TodoProvider.todosProvider(_editTodo!.completed).notifier)
        .getById(editingTodoId);
  }

  void _onFormButtonPressed(
    GlobalKey<FormState> formKey,
    TextEditingController contentFieldController,
  ) async {
    if (!formKey.currentState!.validate()) return;
    if (_editTodo != null) {
      await ref
          .read(TodoProvider.todosProvider(_editTodo!.completed).notifier)
          .edit(id: _editTodo!.id, updatedContent: contentFieldController.text);
    } else {
      await ref
          .read(TodoProvider.todosProvider(false).notifier)
          .add(contentFieldController.text);
      ref.read(SelectionProvider.typeSelectedProvider.notifier).state = false;
    }

    contentFieldController.clear();

    if (mounted) {
      context.go("/home");
    }
  }
}
