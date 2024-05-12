part of 'course_creating_bloc.dart';

abstract class CourseCreatingState extends Equatable {}


//-------------------Created Course------------------------//
final class CourseCreatingInitial extends CourseCreatingState {
  @override
  List<Object?> get props => [];
}
final class CourseCreatingLoading extends CourseCreatingState {
  @override
  List<Object?> get props => [];
}

final class CourseCreatingPost extends CourseCreatingState {
  final Course course;

  CourseCreatingPost({required this.course});
  @override
  List<Object?> get props => [course];
}

final class CourseCreatingLoaded extends CourseCreatingState {
  final Course? course;
  final List<CourseCategory> category;
  CourseCreatingLoaded({required this.course,required this.category});
  @override
  List<Object?> get props => [course, category];
}

final class CourseCreatingError extends CourseCreatingState {
  final String message;
  CourseCreatingError(this.message);
  @override
  List<Object?> get props => [message];
}

final class CourseCreatingErrorList extends CourseCreatingState {
  final Map<String,String> messages;
  CourseCreatingErrorList(this.messages);
  @override
  List<Object?> get props => [messages];
}

//-------------------Course Category------------------------//
final class CourseCategoryInitial extends CourseCreatingState {
  @override
  List<Object?> get props => [];
}

final class CourseCategoryLoading extends CourseCreatingState {
  @override
  List<Object?> get props => [];
}

final class CourseCategoryLoaded extends CourseCreatingState {
  final List<CourseCategory> categories;
  CourseCategoryLoaded(this.categories);
  
  @override
  List<Object?> get props => [categories];
}

final class CourseCategoryError extends CourseCreatingState {
  final String message;
  CourseCategoryError(this.message);
  @override
  List<Object?> get props => [message];
}
