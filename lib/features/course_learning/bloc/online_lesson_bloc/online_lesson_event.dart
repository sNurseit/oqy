part of 'online_lesson_bloc.dart';

abstract class OnlineLessonEvent extends Equatable{}

class LoadOnlineLesson extends OnlineLessonEvent{
  final int lessonId;
  final Completer? completer;

  LoadOnlineLesson({required this.lessonId,  this.completer});

  @override
  List<Object?> get props => [completer, lessonId];
}

