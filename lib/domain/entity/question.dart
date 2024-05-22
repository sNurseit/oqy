import 'package:oqy/domain/entity/answer.dart';

class Question {
  final int? id;
  final int? quizId;
  final String? question;
  final String? image;
  final List<Answer>? answers;

  Question({
    this.id,
    this.quizId,
    this.question,
    this.image,
    this.answers,
  });

  // From JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int?,
      quizId: json['quizId'] as int?,
      question: json['question'] as String?,
      image: json['image'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((answerJson) => Answer.fromJson(answerJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quizId': quizId,
      'question': question,
      'image': image,
      'answers': answers?.map((answer) => answer.toJson()).toList(),
    };
  }
}