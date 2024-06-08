part of 'quiz_edit_bloc.dart';

abstract class QuizEditState extends Equatable {}
//-------------------Created Course------------------------//
final class QuizEditInitial extends QuizEditState {
  @override
  List<Object?> get props => [];
}

final class QuizEditLoaded extends QuizEditState {
  final Quiz quiz;
  QuizEditLoaded({required this.quiz});
  
  @override
  List<Object?> get props => [quiz];
}

final class QuizEditLoading extends QuizEditState {
  @override
  List<Object?> get props => [];
}

final class QuizEditLoadingError extends QuizEditState {
  @override
  List<Object?> get props => [];
}