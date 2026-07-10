import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/models/notification_message.dart';

class ToastProvider {
  static final toastProvider = StateProvider<NotificationMessage?>(
    (ref) => null,
  );

  static final isFromFormPageProvider = StateProvider<bool>((ref) => false);
}
