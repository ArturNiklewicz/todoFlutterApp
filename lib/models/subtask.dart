class SubTask {
  String name;
  String reasonWhy;
  String location;
  bool oneTimeOnly = true;
  bool status;
  bool priority;
  DateTime? time;
  int? reps;

  SubTask(
      {required this.name,
      required this.reasonWhy,
      required this.location,
      required this.status,
      required this.priority});
}
