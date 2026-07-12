import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/selection_provider.dart';
import 'package:todo_app/providers/toast_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _contentFieldKey = GlobalKey<FormFieldState>();
    _contentFieldController = TextEditingController();
    _setContentWhenEdit();
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
        onFormButtonPressed: _onFormButtonPressed,
      ),
    );
  }

  void _onFormButtonPressed(
    GlobalKey<FormState> formKey,
    TextEditingController contentFieldController,
  ) async {
    if (!formKey.currentState!.validate()) return;

    final editingTodo = ref.read(TodoProvider.editingTodoProvider).value;

    if (editingTodo != null) {
      await ref
          .read(TodoProvider.todosProvider(editingTodo.completed).notifier)
          .edit(
            id: editingTodo.id,
            updatedContent: contentFieldController.text,
          );
    } else {
      await ref
          .read(TodoProvider.todosProvider(false).notifier)
          .add(contentFieldController.text);
      ref.read(SelectionProvider.typeSelectedProvider.notifier).state = false;
    }

    ref.read(ToastProvider.isFromFormPageProvider.notifier).state = true;

    if (mounted) {
      context.go("/home");
    }
  }

  void _setContentWhenEdit() {
    ref.listenManual<AsyncValue<TodoModel?>>(TodoProvider.editingTodoProvider, (
      previous,
      next,
    ) {
      final previousTodo = previous?.value;
      final currentTodo = next.value;
      final editingTodoId = ref.read(TodoProvider.editingTodoIdProvider);

      // Edit -> Add
      if (previousTodo != null &&
          currentTodo == null &&
          editingTodoId != null) {
        _contentFieldController.clear();
        return;
      }

      // Add -> Edit
      if (currentTodo != null) {
        _contentFieldController.text = currentTodo.content;
      }
    });
  }
}
