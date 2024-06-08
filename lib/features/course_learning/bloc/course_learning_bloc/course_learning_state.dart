part of 'course_learning_bloc.dart';

abstract class CourseLearningState extends Equatable {}

final class CourseLearningInitial extends CourseLearningState {
  @override
  List<Object?> get props => [];
}
final class CourseLearningLoading extends CourseLearningState {
  @override
  List<Object?> get props => [];
}

final class CourseLearningLoaded extends CourseLearningState {

  final Course course;
  CourseLearningLoaded({required this.course});
  @override
  List<Object?> get props => [course];
}

final class CourseLearningLoadingError extends CourseLearningState {
  @override
  List<Object?> get props => [];
}