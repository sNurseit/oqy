import 'package:oqy/domain/entity/question.dart';
import 'package:oqy/domain/entity/quiz_point.dart';

class Quiz {
   int? id;
   int? courseId;
   Duration? duration;
   String? durationString;
   String? title;
   String? instruction;
   int? step;
   List<Question>? questions;
   QuizPoint? quizPoint;

  Quiz({
    this.id,
    this.courseId,
    this.duration,
    this.durationString,
    this.title,
    this.instruction,
    this.step,
    this.questions,
    this.quizPoint,
  });

  // From JSON
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as int?,
      courseId: json['courseId'] as int?,
      duration: json['duration'] != null ? Duration(seconds: json['duration']) : null,
      durationString: json['durationString'] as String?,
      title: json['title'] as String?,
      instruction: json['instruction'] as String?,
      step: json['step'] as int?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((questionJson) => Question.fromJson(questionJson as Map<String, dynamic>))
          .toList(),
      quizPoint: json['quizPoint'] != null ? QuizPoint.fromJson(json['quizPoint'] as Map<String, dynamic>) : null,
    );
  }

  // To JSON
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
    };
  }
}
