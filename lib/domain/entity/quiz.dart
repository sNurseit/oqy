import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/question.dart';
import 'package:oqy/domain/entity/quiz_point.dart';

class Quiz extends StepItem {
  @override
  int? id;
  int? courseId;
  Duration? duration;
  String? durationString;
  @override
  String title;
  String? instruction;
  @override
  int step;
  List<Question>? questions;
  QuizPoint? quizPoint;
  String? uuid;

  Quiz({
    required this.id,
    this.courseId,
    this.duration,
    this.durationString,
    required this.title,
    this.instruction,
    required this.step,
    this.questions,
    this.quizPoint,
    this.uuid,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      courseId: json['courseId'] ,
      duration: json['duration'] != null ? Duration(seconds: json['duration']) : null,
      durationString: json['durationString'],
      title: json['title'],
      instruction: json['instruction'] ,
      step: json['step'],
      questions: (json['questions'] as List<dynamic>?)
          ?.map((questionJson) => Question.fromJson(questionJson as Map<String, dynamic>))
          .toList(),
      quizPoint: json['quizPoint'] != null ? QuizPoint.fromJson(json['quizPoint'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'duration': duration?.inSeconds,
      'durationString': durationString,
      'title': title,
      'instruction': instruction,
      'step': step,
      'questions': questions?.map((question) => question.toJson()).toList(),
      'quizPoint': quizPoint?.toJson(),
      'moduleType':'quiz',
    };
  }
}
