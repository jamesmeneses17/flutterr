class Task {
  final String title;
  final String description;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // Convertir JSON a Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Convertir Task a JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  // Método para copiar la tarea con modificaciones
  Task copyWith({bool? isCompleted}) {
    return Task(
      title: title,
      description: description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
