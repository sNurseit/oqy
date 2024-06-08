import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/online_lesson.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_service_impl.dart';
import 'package:oqy/service/module_service.dart';
import 'package:oqy/service/quiz_service.dart';

part 'course_learning_event.dart';
part 'course_learning_state.dart';

class CourseLearningBloc extends Bloc<CourseLearningEvent, CourseLearningState> {

  CourseService courseService;
  ModuleService moduleService;
  QuizService quizService;

  CourseLearningBloc({required this.courseService, required this.moduleService, required this.quizService}) : super(CourseLearningInitial()) {
    on<LoadCourseLearning>((event, emit) async {
      try{
        emit(CourseLearningLoading());
        final course = await courseService.getOneCourse(event.courseId);
        course.quizzes = await quizService.findAllByCourseId(event.courseId);
        emit(CourseLearningLoaded(course: course));
      } catch (e){
        emit(CourseLearningLoadingError());
      } finally{
        event.completer?.complete();
      }
    });

    on<NavigateToModule>((event,emit){
      AutoRouter.of(event.context).push(ModuleLearnRoute(module: event.module, materialIndex: 0));
    });

    on<NavigateToOnlineLesson>((event,emit){
      AutoRouter.of(event.context).push(OnlineLessonRoute(courseId: event.onlineLesson.id!, roomId: event.onlineLesson.id!));
    });
  }
}
