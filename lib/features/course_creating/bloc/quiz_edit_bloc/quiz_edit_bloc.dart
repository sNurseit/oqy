import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/entity/question.dart';
import 'package:oqy/domain/entity/quiz.dart';
import 'package:oqy/service/question_service.dart';
import 'package:oqy/service/quiz_service.dart';

part 'quiz_edit_event.dart';
part 'quiz_edit_state.dart';

class QuizEditBloc extends Bloc<QuizEditEvent, QuizEditState> {

  QuizService quizServices;
  QuestionService questionServices;
  Quiz? quiz;

  QuizEditBloc({required this.quizServices, required this.questionServices}) : super(QuizEditInitial()) {
    on<LoadQuizEdit>((event, emit) async {
      try{
        emit(QuizEditLoading());
        quiz = await quizServices.findById(event.id);
        emit(QuizEditLoaded(quiz: quiz!));
      } catch(e){
        emit(QuizEditLoadingError());
      } finally {
        event.completer?.complete();
      }
    });
  }
}
