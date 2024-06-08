part of 'question_edit_bloc.dart';

abstract class QuestionEditEvent extends Equatable{}

class LoadQuestionEdit extends QuestionEditEvent{
  final int quizId;
  final int courseId;
  final Completer? completer;
  final bool editing;

  LoadQuestionEdit({required this.quizId, required this.courseId, this.completer, required this.editing,});
  @override
  List<Object?> get props => [quizId, courseId, completer, editing];
}

class CreateQuestion extends QuestionEditEvent{
  final Question question;
  CreateQuestion({required this.question});
  
  @override
  List<Object?> get props => [];
}

class CreateAnswer extends QuestionEditEvent{
  final int questionId;
  final Answer answer;

  CreateAnswer({required this.questionId, required this.answer});
  @override
  List<Object?> get props => [questionId, answer];
}
