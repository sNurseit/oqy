import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/entity/answer.dart';
import 'package:oqy/domain/entity/question.dart';
import 'package:oqy/service/answer_service.dart';
import 'package:oqy/service/question_service.dart';
import 'package:oqy/service/quiz_service.dart';

part 'question_edit_event.dart';
part 'question_edit_state.dart';

class QuestionEditBloc extends Bloc<QuestionEditEvent, QuestionEditState> {

  QuizService quizServices;
  QuestionService questionServices;
  AnswerService answerService;

  List<Question> questions = [];
  bool changed = false;

  QuestionEditBloc({required this.questionServices, required this.quizServices, required this.answerService}) : super(QuestionEditInitial()) {
    on<LoadQuestionEdit>((event, emit) async {
      try{
        emit(QuestionEditLoading());
        questions = await questionServices.findAllByQuizId(event.quizId);
        emit(QuestionEditLoaded(questions: questions, showSnackBar: false));
      } catch(e){
        emit(QuestionEditLoadingError());
      } finally{
        event.completer?.complete();
      }
    });

    on<CreateAnswer>((event, emit) async {
      if(event.answer.id == null){
        try{
          emit(QuestionEditLoading());
          for(int questionIndex = 0; questionIndex <questions.length; questionIndex++){
            if(questions[questionIndex].id == event.answer.questionId!){
              final answer = await answerService.create(event.answer);
              questions[questionIndex].answers!.add(answer);
              emit(QuestionEditLoaded(questions: questions, showSnackBar: false));
              return;
            }
          }
          emit(QuestionEditLoaded(questions: questions, showSnackBar: true));
        } catch(e){
          emit(QuestionEditLoaded(questions: questions, showSnackBar: true));
        }
      } else{
        try{
          emit(QuestionEditLoading());
          for(int questionIndex = 0; questionIndex <questions.length; questionIndex++){
            if(questions[questionIndex].id == event.answer.questionId!){

              for(int answerIndex = 0; answerIndex < questions[questionIndex].answers!.length; answerIndex++){
                if(questions[questionIndex].answers![answerIndex].id == event.answer.id){
                  final answer = await answerService.update(event.answer);
                  questions[questionIndex].answers![answerIndex] = answer;
                  emit(QuestionEditLoaded(questions: questions, showSnackBar: false));
                  return;
                }
              }

            }
          }
          emit(QuestionEditLoaded(questions: questions, showSnackBar: true));
        } catch(e){
          emit(QuestionEditLoaded(questions: questions, showSnackBar: true));
        }
      }
    });

    on<CreateQuestion>((event, emit) async {
      if(event.question.id == null){
        try {
          final question = await questionServices.create(event.question);
          questions.add(question);
          emit(QuestionEditLoaded(questions: questions, showSnackBar: false));
        } catch (e) {
          emit(QuestionEditLoaded(questions: questions, showSnackBar: true));
        }
      } else{
        try {
          for(int questionIndex = 0; questionIndex <questions.length; questionIndex++){
            if(questions[questionIndex].id == event.question.id!){
              final question = await questionServices.update(event.question);
              questions[questionIndex]= question;
              emit(QuestionEditLoaded(questions: questions, showSnackBar: false));
              return;
            }
          }
          emit(QuestionEditLoaded(questions: questions, showSnackBar: true));
        } catch (e) {
          emit(QuestionEditLoaded(questions: questions, showSnackBar: true));
        }
      }

    });
  }
}
