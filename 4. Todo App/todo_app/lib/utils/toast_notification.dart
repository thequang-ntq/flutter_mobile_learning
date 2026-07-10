import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_app/extensions/context_extension.dart';

class ToastNotification {
  static void showSuccess(BuildContext context, {required String message}) {
    final text = context.text;
    final colors = context.colors;

    _show(
      type: ToastificationType.success,
      title: message,
      style: text.titleLarge!.copyWith(color: colors.onPrimary),
      icon: Icons.check_circle_rounded,
      color: colors.onPrimary,
    );
  }

  static void showError(BuildContext context, {required String message}) {
    final text = context.text;
    final colors = context.colors;

    _show(
      type: ToastificationType.error,
      title: message,
      style: text.titleLarge!.copyWith(color: colors.onPrimary),
      icon: Icons.cancel_rounded,
      color: colors.onPrimary,
    );
  }

  static void showInfo(BuildContext context, {required String message}) {
    final text = context.text;
    final colors = context.colors;

    _show(
      type: ToastificationType.info,
      title: message,
      style: text.titleLarge!.copyWith(color: colors.onPrimary),
      icon: Icons.info,
      color: colors.onPrimary,
    );
  }

  static void _show({
    required ToastificationType type,
    required String title,
    required TextStyle style,
    required IconData icon,
    required Color color,
  }) {
    toastification.show(
      type: type,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(title, style: style),
      alignment: Alignment.topCenter,
      icon: Icon(icon, color: color),
      showIcon: true,
      showProgressBar: true,
      closeOnClick: true,
      dragToClose: true,
      pauseOnHover: true,
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(8),
    );
  }
}
