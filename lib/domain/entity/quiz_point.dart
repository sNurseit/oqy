class QuizPoint {
  final int? id;
  final int? quizId;
  final int? userId;
  final int? point;
  final int? totalPoint;

  QuizPoint({
    this.id,
    this.quizId,
    this.userId,
    this.point,
    this.totalPoint,
  });

  // From JSON
  factory QuizPoint.fromJson(Map<String, dynamic> json) {
    return QuizPoint(
      id: json['id'] as int?,
      quizId: json['quiz_id'] as int?,
      userId: json['user_id'] as int?,
      point: json['point'] as int?,
      totalPoint: json['total_point'] as int?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_id': quizId,
      'user_id': userId,
      'point': point,
      'total_point': totalPoint,
    };
  }
}
