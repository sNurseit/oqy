part of 'course_learning_bloc.dart';

abstract class CourseLearningEvent extends Equatable{}

class LoadCourseLearning extends CourseLearningEvent{
  final int courseId;
  final Completer? completer;

  LoadCourseLearning({required this.courseId, this.completer});
  @override
  List<Object?> get props => [courseId, completer];
}

class NavigateToModule extends CourseLearningEvent {
  
  final StepItem module;
  final BuildContext context;

  NavigateToModule({required this.context, required this.module});

  @override
  List<Object?> get props => [context,module];
}



class NavigateToOnlineLesson extends CourseLearningEvent {
  final int courseId;
  final OnlineLesson onlineLesson;
  final BuildContext context;

  NavigateToOnlineLesson({required this.courseId, required this.context, required this.onlineLesson});

  @override
  List<Object?> get props => [context,onlineLesson];
}