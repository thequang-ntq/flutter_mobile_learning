import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class SelectedTodoIdsNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() {
    return {};
  }

  void add(int id) {
    state = {...state, id};
  }

  void remove(int id) {
    final newState = {...state};
    newState.remove(id);
    state = newState;
  }

  void clear() {
    state = {};
  }

  void toggle(int id) {
    if (state.contains(id)) {
      remove(id);
    } else {
      add(id);
    }
  }

  void selectAll(Iterable<int> ids) {
    state = ids.toSet();
  }

  bool contains(int id) {
    return state.contains(id);
  }

  int length() {
    return state.length;
  }
}

class SelectionProvider {
  SelectionProvider._();

  static final isSelectionModeProvider =
      NotifierProvider<IsSelectionModeNotifier, bool>(
        IsSelectionModeNotifier.new,
      );

  static final selectedTodoIdsProvider =
      NotifierProvider<SelectedTodoIdsNotifier, Set<int>>(
        SelectedTodoIdsNotifier.new,
      );
}
