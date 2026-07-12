import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/extensions/context_extension.dart';
import 'package:todo_app/providers/todo_provider.dart';

class FormBody extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> contentFieldKey;
  final TextEditingController contentFieldController;
  final Function(GlobalKey<FormState>, TextEditingController)
  onFormButtonPressed;

  const FormBody({
    super.key,
    required this.formKey,
    required this.contentFieldKey,
    required this.contentFieldController,
    required this.onFormButtonPressed,
  });

  @override
  ConsumerState<FormBody> createState() => _FormBodyState();
}

class _FormBodyState extends ConsumerState<FormBody> {
  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          width * 0.05,
          height * 0.035,
          width * 0.05,
          height * 0.035,
        ),
        child: _buildForm(context, ref: ref),
      ),
    );
  }

  Widget _buildForm(BuildContext context, {required WidgetRef ref}) {
    final text = context.text;
    final colors = context.colors;
    final height = context.height;
    final editTodo = ref.watch(TodoProvider.editingTodoProvider);

    return editTodo.when(
      data: (todo) {
        return Form(
          key: widget.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: height * 0.04,
                children: [
                  TextFormField(
                    key: widget.contentFieldKey,
                    controller: widget.contentFieldController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    cursorColor: colors.primary,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: todo == null
                          ? "What's your task today?"
                          : "Edit your task's content",
                      labelStyle: text.titleLarge!.copyWith(
                        color: colors.onSurface,
                      ),
                      hintText: "For example: Read a book...",
                      hintStyle: text.labelLarge!.copyWith(
                        color: colors.outline,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: colors.onSurface,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: colors.primary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: colors.error),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter task's content";
                      }

                      return null;
                    },
                    onTap: () {
                      widget.contentFieldKey.currentState!.clearError();
                    },
                  ),
                  todo != null
                      ? InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Last updated",
                            labelStyle: text.titleLarge!.copyWith(
                              color: colors.onSurface,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: colors.onSurface,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: colors.outlineVariant,
                          ),
                          child: Text(
                            "${todo.timestamp}",
                            style: text.labelLarge!.copyWith(
                              color: colors.onSurface,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.fromLTRB(0, height * 0.015, 0, height * 0.015),
                    ),
                    backgroundColor: WidgetStatePropertyAll(colors.primary),
                  ),
                  onPressed: () {
                    widget.onFormButtonPressed(
                      widget.formKey,
                      widget.contentFieldController,
                    );
                  },
                  child: Text(
                    todo != null ? "Edit" : "Add",
                    style: text.titleLarge!.copyWith(color: colors.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            "Error: $error",
            style: text.titleLarge!.copyWith(color: colors.error),
            textAlign: TextAlign.center,
          ),
        );
      },

      loading: () {
        return Center(
          child: CircularProgressIndicator(color: colors.onSurface),
        );
      },
    );
  }
}
