import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/entity/online_lesson.dart';
import 'package:oqy/domain/provider/session_provider.dart';
import 'package:oqy/service/online_lesson_service.dart';

part 'online_lesson_event.dart';
part 'online_lesson_state.dart';

class OnlineLessonBloc extends Bloc<OnlineLessonEvent, OnlineLessonState> {

  SessionDataProvider sessionDataProvider = SessionDataProvider();
  OnlineLessonService onlineLessonService;
  OnlineLessonBloc({required this.onlineLessonService}) : super(OnlineLessonInitial()) {
    on<LoadOnlineLesson>((event, emit) async {
      try{
        final lesson = await onlineLessonService.findById(event.lessonId);
        final session = await sessionDataProvider.getSessions();
        emit(OnlineLessonLoaded(onlineLesson: lesson, userId: session.userId, userName: '${session.userId}'));
      } catch(e){
         
      } finally{
        event.completer?.complete();
      }
    });
  }
}
