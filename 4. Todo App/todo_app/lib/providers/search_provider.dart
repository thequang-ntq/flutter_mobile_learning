import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/services/todo_service.dart';

class SearchProvider {
  static final searchHistoryProvider =
      FutureProvider.family<List<String>, bool>((ref, isCompleted) async {
        return TodoService.getSearchHistory(isCompleted);
      });
}
