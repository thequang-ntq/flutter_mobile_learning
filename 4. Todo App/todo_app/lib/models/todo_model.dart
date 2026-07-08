class TodoModel {
  final int id;
  final String content;
  final bool completed;
  final DateTime timestamp;

  const TodoModel({
    required this.id,
    required this.content,
    required this.completed,
    required this.timestamp,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"] as int,
      content: json["content"] as String,
      completed: json["completed"] as bool,
      timestamp: DateTime.parse(json["timestamp"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "completed": completed,
      "timestamp": timestamp.toIso8601String(),
    };
  }
}
