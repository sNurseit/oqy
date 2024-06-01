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
  @override
  String? description;
  @override
  int step;
  List<Question>? questions;
  QuizPoint? quizPoint;


  Quiz({
    required this.id,
    this.courseId,
    this.duration,
    this.durationString,
    required this.title,
    this.description,
    required this.step,
    this.questions,
    this.quizPoint,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    
    return Quiz(
      id: json['id'],
      courseId: json['courseId'] ,
      duration: json['duration'] != null ? Duration(seconds: json['duration']) : null,
      durationString: json['durationString'],
      title: json['title'],
      description: json['instruction'] ,
      step: json['step'],
      questions: json['questions']!=null
        ? List<Question>.from(json['questions'].map((question) => Question.fromJson(question))) : [],
      quizPoint: json['quizPoint'] != null ? QuizPoint.fromJson(json['quizPoint'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>?questionsJson;
    if (questions != null) {
      questionsJson = questions!.map((question) => question.toJson()).toList();
    }
    return {
      'id': id,
      'courseId': courseId,
      'duration': duration?.inSeconds,
      'durationString': durationString,
      'title': title,
      'instruction': description,
      'step': step,
      'questions': questionsJson??[],
      'quizPoint': quizPoint?.toJson(),
    };
  }
}
