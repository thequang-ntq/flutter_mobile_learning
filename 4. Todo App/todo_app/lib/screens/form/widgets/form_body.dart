import 'package:flutter/material.dart';
import 'package:todo_app/extensions/context_extension.dart';

class FormBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final GlobalKey<FormFieldState> contentFieldKey;
  final TextEditingController contentFieldController;

  const FormBody({
    super.key,
    required this.formKey,
    required this.contentFieldKey,
    required this.contentFieldController,
  });

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
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    final text = context.text;
    final colors = context.colors;
    final height = context.height;

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: height * 0.04,
            children: [
              TextFormField(
                key: contentFieldKey,
                controller: contentFieldController,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                cursorColor: colors.primary,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "What's your task today?",
                  labelStyle: text.titleLarge!.copyWith(
                    color: colors.onSurface,
                  ),
                  hintText: "For example: Read a book...",
                  hintStyle: text.labelLarge!.copyWith(color: colors.outline),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: colors.onSurface),
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
                  contentFieldKey.currentState!.clearError();
                },
              ),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: "Last updated",
                  labelStyle: text.titleLarge!.copyWith(
                    color: colors.onSurface,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: colors.onSurface),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: colors.outlineVariant,
                ),
                child: Text(
                  "todo timestamp here",
                  style: text.labelLarge!.copyWith(color: colors.onSurface),
                ),
              ),
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
              onPressed: () {},
              child: Text(
                "Add/Edit...",
                style: text.titleLarge!.copyWith(color: colors.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
