import 'package:todo_app/models/todo_model.dart';

class SkeletonTodosData {
  static final skeletonTodos = List.generate(
    6,
    (index) => TodoModel(
      id: index,
      content: 'Loading todo',
      completed: false,
      timestamp: DateTime.now(),
    ),
  );
}
