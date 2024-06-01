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
  final List<ModuleType> courseModules;
  CourseCreatingLoaded({required this.course,required this.category, required this.courseModules,});

  @override
  List<Object?> get props => [course, category, courseModules];
}

final class ModuleAdded extends CourseCreatingState{
  final List<ModuleType>? modules;

  ModuleAdded({required this.modules});

  @override
  List<Object?> get props => [modules];
}

final class ModuleLoaded extends CourseCreatingState{
  final Module module;
  ModuleLoaded({required this.module});
  @override
  List<Object?> get props => [module];
}

final class ModuleLoading extends CourseCreatingState {
  @override
  List<Object?> get props => [];
}

final class MaterialLoaded extends CourseCreatingState{
  final MaterialEntity material;
  MaterialLoaded({required this.material});
  @override
  List<Object?> get props => [material];
}

final class MaterialLoading extends CourseCreatingState {
  @override
  List<Object?> get props => [];
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
