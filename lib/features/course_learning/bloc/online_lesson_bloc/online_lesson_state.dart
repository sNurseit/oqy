part of 'online_lesson_bloc.dart';


abstract class OnlineLessonState extends Equatable {}

final class OnlineLessonInitial extends OnlineLessonState {
  @override
  List<Object?> get props => [];
}

final class OnlineLessonLoaded extends OnlineLessonState {
  final OnlineLesson onlineLesson;
  final int userId;
  final String userName;
  OnlineLessonLoaded({required this.onlineLesson, required this.userId, required this.userName});
  @override
  List<Object?> get props => [onlineLesson,userId,userName];
}
