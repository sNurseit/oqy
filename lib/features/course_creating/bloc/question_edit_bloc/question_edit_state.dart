part of 'question_edit_bloc.dart';


abstract class QuestionEditState extends Equatable {}
//-------------------Created Course------------------------//
final class QuestionEditInitial extends QuestionEditState {
  @override
  List<Object?> get props => [];
}

final class QuestionEditLoaded extends QuestionEditState {
  final List<Question> questions;
  final bool showSnackBar;
  QuestionEditLoaded({required this.questions, required this.showSnackBar});
  
  @override
  List<Object?> get props => [questions, showSnackBar];
}

final class QuestionEditLoading extends QuestionEditState {
  @override
  List<Object?> get props => [];
}

final class QuestionEditLoadingError extends QuestionEditState {
  @override
  List<Object?> get props => [];
}