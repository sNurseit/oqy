class Answer {
  final int? id;
  final int? questionId;
  final String? answerText;
  final bool? correct;

  Answer({
    this.id,
    this.questionId,
    this.answerText,
    this.correct,
  });

  // From JSON
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as int?,
      questionId: json['questionId'] as int?,
      answerText: json['answerText'] as String?,
      correct: json['correct'] as bool?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'answerText': answerText,
      'correct': correct,
    };
  }
}