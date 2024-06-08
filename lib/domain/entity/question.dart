import 'package:oqy/domain/entity/answer.dart';

class Question {
  int? id;
  int? quizId;
  String? question;
  String? image;
  List<Answer>? answers = [];
  bool changed = false;

  Question({
    this.id,
    this.quizId,
    this.question,
    this.image,
    this.answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int?,
      quizId: json['quizId'] as int?,
      question: json['question'] as String?,
      image: json['image'] as String?,
      answers: json['answers']!=null
        ? List<Answer>.from(json['answers'].map((answers) => Answer.fromJson(answers))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quizId': quizId,
      'question': question,
      'image': image,
      'answers': answers!=null ? answers?.map((answer) => answer.toJson()).toList() : [],
    };
  }
}