class TaskModel {
  final String id;
  String title;
  String description;
  DateTime dueDate;
  String priority;
  String tag;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.tag,
    this.isCompleted = false,
  });
}
