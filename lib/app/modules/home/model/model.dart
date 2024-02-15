class ToDoModel {
  int? id;
  String? title;
  bool? status; // checkbox
  String? description;
  String? dateTime;
  Function(int)? onDelete;

  @override
  String toString() {
    return 'ToDoModel{id: $id, title: $title, status: $status, description: $description, dateTime: $dateTime, onDelete: $onDelete}';
  }

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.status,
    required this.onDelete,
  });
}