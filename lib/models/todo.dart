final String tableTodos = 'todos';

class TodoFields {
  static final List<String> values = [id, title, weight, milestone, status];
  static final String id = '_id';
  static final String title = 'title';
  static final String weight = 'weight';
  static final String milestone = 'milestone';
  static final String status = 'status';
}

class Todo {
  final int? id;
  final String title;
  final double weight;
  final DateTime milestone;
  bool status;

  Todo({
    this.id,
    required this.title,
    required this.weight,
    required this.milestone,
    required this.status,
  });

  Todo copy({
    int? id,
    String? title,
    double? weight,
    DateTime? milestone,
    bool? status,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        weight: weight ?? this.weight,
        milestone: milestone ?? this.milestone,
        status: status ?? this.status,
      );

  static Todo fromJson(Map<String, Object?> json) => Todo(
        id: json[TodoFields.id] as int?,
        title: json[TodoFields.title] as String,
        weight: json[TodoFields.weight] as double,
        milestone: DateTime.parse([TodoFields.milestone] as String),
        status:
            json[TodoFields.status] == 1, // TODO! check what status should be
      );

  Map<String, Object?> toJson() => {
        TodoFields.id: id,
        TodoFields.title: title,
        TodoFields.weight: weight,
        TodoFields.milestone: milestone.toIso8601String(),
        TodoFields.status: status ? 1 : 0, //TODO! check what status should be
      };
}
