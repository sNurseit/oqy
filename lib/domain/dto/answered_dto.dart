class AnsweredDto {
  final int questionId;
  final List<int> selectedAnswers;

  AnsweredDto({
    required this.questionId,
    required this.selectedAnswers,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedAnswers': selectedAnswers,
    };
  }

  factory AnsweredDto.fromJson(Map<String, dynamic> json) {
    return AnsweredDto(
      questionId: json['questionId'] as int,
      selectedAnswers: List<int>.from(json['selectedAnswers']),
    );
  }
}
