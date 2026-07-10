import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class IsSelectionModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void enable() {
    state = true;
  }

  void disable() {
    state = false;
  }

  void toggle() {
    state = !state;
  }
}

class SelectionProvider {
  SelectionProvider._();

  static final isSelectionModeProvider =
      NotifierProvider<IsSelectionModeNotifier, bool>(
        IsSelectionModeNotifier.new,
      );

  static final typeSelectedProvider = StateProvider<bool>((ref) => false);
}
