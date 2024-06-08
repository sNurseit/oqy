class Answer {
  int? id;
  int? questionId;
  String? answerText;
  bool? correct;
  String? image;


  Answer({
    this.id,
    this.questionId,
    this.answerText,
    this.correct,
    this.image,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as int?,
      questionId: json['questionId'] as int?,
      answerText: json['answerText'] as String?,
      correct: json['correct'] as bool?,
      image: json['image'] as String?,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'answerText': answerText,
      'image': image,
      'correct': correct,
    };
  }
}