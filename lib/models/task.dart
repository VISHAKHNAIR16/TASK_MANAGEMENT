class Task {
  final int status, id , priority,type;
  final String content;
  final DateTime? dueDate;


  Task({
    required this.id,
    required this.status,
    required this.priority,
    required this.content,
    required this.dueDate,
    required this.type,
  });
}