part of 'quiz_edit_bloc.dart';

abstract class QuizEditEvent extends Equatable{}

class LoadQuizEdit extends QuizEditEvent{
  final int id;
  final int courseId;
  final Completer? completer;

  LoadQuizEdit({required this.id, required this.courseId, this.completer});
  @override
  List<Object?> get props => [id, courseId, completer];
}


class CreateQuestion extends QuizEditEvent{
  final int moduleId;
  final int courseId;
  final Question question;

  CreateQuestion({required this.moduleId, required this.courseId, required this.question});
  @override
  List<Object?> get props => [moduleId, courseId, question];
}
