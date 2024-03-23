class Module{
  final int id;
  final int courseId;
  final String title;
  final String description;
  final int? totalSteps;

  Module({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    this.totalSteps,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      totalSteps: json['totalSteps'],
    );
  }
}