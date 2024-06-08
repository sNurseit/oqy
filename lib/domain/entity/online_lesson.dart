class OnlineLesson {
  final int? id;
  final int? courseId;
  final String? title;
  final String? description;
  final DateTime? dateOfStart;
  final DateTime? date;
  final String? time;

  OnlineLesson({
    this.id,
    this.courseId,
    this.title,
    this.description,
    this.dateOfStart,
    this.date,
    this.time,
  });

  // From JSON
  factory OnlineLesson.fromJson(Map<String, dynamic> json) {
    return OnlineLesson(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      dateOfStart: json['dateOfStart'] != null ? DateTime.parse(json['dateOfStart']) : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      time: json['time'] ,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'dateOfStart': dateOfStart?.toIso8601String(),
      'date': date?.toIso8601String(),
      'time': time,
    };
  }
}
