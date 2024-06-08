import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/course_category.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/domain/entity/online_lesson.dart';
import 'package:oqy/domain/entity/quiz.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_category_service.dart';
import 'package:oqy/service/course_service_impl.dart';
import 'package:oqy/service/module_service.dart';
import 'package:oqy/service/quiz_service.dart';

part 'course_creating_event.dart';
part 'course_creating_state.dart';




class CourseCreatingBloc extends Bloc<CourseCreatingEvent, CourseCreatingState> {
  CourseService courseService;
  CourseCategoryService courseCategoryService;
  ModuleService moduleService;
  QuizService quizService;

  Course course = Course.empty();
  List<CourseCategory>? categoryList;
  List<ModuleType> courseModules = [];

  CourseCreatingBloc({
    required this.courseService, 
    required this.courseCategoryService,
    required this.moduleService,
    required this.quizService,
  }) : super(CourseCreatingInitial()) {

    on<LoadCourseCreating>((event, emit) async {
      if(event.courseId != null && event.courseId! > 0){
        try{
          if(event.completer==null){
            emit(CourseCreatingLoading());
          }
          course = await courseService.myCreatedCourse(event.courseId!);
          categoryList = await courseCategoryService.getAllCategories();
          course.quizzes = await quizService.findAllByCourseId(event.courseId!);
          updateModules(course.modules!, course.quizzes!);
          emit(CourseCreatingLoaded(course: course, category: categoryList!, courseModules:courseModules)); 
        } catch(e){
          emit(CourseCategoryError('Something wrong'));
        } finally{
          event.completer?.complete();
        }
      } else{
        emit(CourseCreatingLoading());
        final List<CourseCategory> categoryList = await courseCategoryService.getAllCategories();
        course = Course.empty();
        emit(CourseCreatingLoaded(course: course, category: categoryList, courseModules:courseModules));
        event.completer?.complete();
      }
    });
    //------------------Course Category--------------------------------//
    on<LoadCourseCategory>((event,emit) async{
      try{
        emit(CourseCategoryLoading());
        categoryList = await courseCategoryService.getAllCategories();
        emit(CourseCategoryLoaded(categoryList!));
      } catch (e) {
        emit(CourseCategoryError('Something wrong'));
      } finally{
        event.completer?.complete();
      }
    });

    on<NavigateToModule>((event,emit){
      if(event.moduleType is Module){
        AutoRouter.of(event.buildContext).push(ModuleRoute(moduleId:event.moduleType.id!, ));
      } else{
        AutoRouter.of(event.buildContext).push(QuizEditRoute(id: event.moduleType.id!, courseId: course.id!,));
      }
/*
      if(module == null){
        Quiz quiz = course.quizzes!.firstWhere(
          (quiz) => quiz.step == event.moduleType.step,
        );
        //AutoRouter.of(event.buildContext).replace(route);
      }
      else{
      }
*/
    });

    on<NavigateToMaterial>((event,emit){
      try{
        AutoRouter.of(event.buildContext).push(MaterialEditRoute(materialStep: event.materialStep,moduleStep: event.moduleStep));        
      } catch(e){
        throw Exception(e);
      }
    });


    on<LoadModule>((event,emit) async {
      try{
        emit(ModuleLoading());
        for (int index = 0; index < course.modules!.length; index++){
          if(course.modules![index].step == event.step){
            if(course.modules![index].id != null){
              Module requestModule = await moduleService.findById(course.modules![index].id!);
              course.modules![index].materials = requestModule.materials;
            }
            emit(ModuleLoaded(module: course.modules![index]));
            return;
          }
        }
      }
      catch(e){
        throw Exception(e);
      }
    });

    
    on<PopNavigate>((event,emit){
      emit(CourseCreatingLoading());
      emit(CourseCreatingLoaded(course: course, category: categoryList!, courseModules:courseModules));
      Navigator.of(event.buildContext).pop();
    });


    on<AddModule>((event, emit) async {
      emit(CourseCreatingLoading());

      Map<String,String> validatedInputs = validateModuleInputs(event.title, event.description, event.type);
      if(validatedInputs.isNotEmpty){
        emit(CourseCreatingErrorList(validatedInputs));
      } else{
        switch(event.type){
          case 0:            
            if(event.id !=null){
              final module = await moduleService.update(Module(id: event.id, title: event.title, description: event.description , step: event.step!, courseId: course.id, ));
              course.updateModuleById(module);
            }else{
              final combinedItems = [...?course.modules, ...?course.quizzes];
              final module = await moduleService.create(Module(id: null, title: event.title, step:getMaxStep(combinedItems), courseId: course.id, ));
              course.modules!.add(module);
            }
            break;
          case 1:
             if(event.id !=null){
              final quiz = await quizService.update(
                  Quiz(
                    id: event.id,                    
                    title: event.title,
                    description:event.description,
                    step: event.step!,
                    courseId: course.id,
                  )
              );
              course.updateQuizById(quiz);
            }else{
              final combinedItems = [...?course.modules, ...?course.quizzes];
              final quiz = await quizService.create(Quiz(id: null, title: event.title, description:event.description, step:getMaxStep(combinedItems), courseId: course.id, ));
              course.quizzes!.add(quiz);
            }
            break;
          case 2:
            course.onlineLessons!.add(
              OnlineLesson(
                title: event.title,
                description: event.description,
              )
            );
            break;
        }
        Navigator.of(event.context).pop();
        emit(CourseCreatingLoaded(course: course, category: categoryList!, courseModules:courseModules));
      }
    });

    on<PostCourseMainInformation>((event, emit) async{
      Map<String,String> validatedInputs = validateInput(event.course);
      if(validatedInputs.isNotEmpty){
        emit(CourseCreatingErrorList(validatedInputs));
      } else {
        try {
          emit(CourseCreatingLoading());
          event.course.id = course.id;
          course = await courseService.create(event.course);
          final List<CourseCategory> categoryList = await courseCategoryService.getAllCategories();
          emit(CourseCreatingLoaded(course: course, category: categoryList, courseModules:courseModules));
        } catch (e){
          emit(CourseCreatingError('Something wrong'));
        } finally{
          event.completer?.complete();
        }
      }
    });
  }

  Module? getModuleByStep(int step) {
    return course.modules?.firstWhere((module) => module.step == step, );
  }

  int getMaxStep(List<dynamic> items) {
    if (items.isEmpty) {
      return 0;
    }
    return items.map((item) => item.step).reduce((a, b) => a > b ? a : b);
  }
  
  Quiz? getQuizByStep(int step) {
    return course.quizzes?.firstWhere((quiz) => quiz.step == step, );
  }

  void updateModules(List<Module> modules, List<Quiz> quizes) {
    int moduleId = 0;
    int quizId = 0;
    int modulesLength = modules.length;
    int quizesLength = quizes.length;

    List<ModuleType> typeList = [];
    while (modulesLength > 0 || quizesLength > 0) {
      if(modulesLength > 0){
        typeList.add(
          ModuleType(
            id: modules[moduleId].id, 
            type: 'module', 
            title: modules[moduleId].title,
            step: modules[moduleId].step,
          )
        );
        modulesLength --;
        moduleId ++;
      }
      if (quizesLength > 0){
        typeList.add(
          ModuleType(
            id: quizes[quizId].id, 
            type: 'quiz', 
            title: quizes[quizId].title,
            step: quizes[quizId].step,
          )
        );
        quizesLength --;
        quizId ++;
      }
    }
    courseModules = typeList;
  }
  Map<String, String> validateModuleInputs(String title,  String description, int type){
      Map<String, String> inputValidations ={};
      if(title.isEmpty){
        inputValidations['title'] = 'Title can`t be empty';
      }
      if(description.isEmpty){
        inputValidations['description'] = 'description can`t be empty';
      }
      if(type.isNaN){
        inputValidations['type'] = 'type can`t be empty';
      }
      return inputValidations;
  }

  Map<String, String> validateInput(Course myCourse){
    Map<String, String> inputValidations ={};
    if(myCourse.language == null || myCourse.language!.isEmpty){
      inputValidations['language'] = 'Language can`t be empty';
    }
    if(myCourse.title == null || myCourse.title!.isEmpty){
      inputValidations['title'] = 'title can`t be empty';
    }
    if(myCourse.description == null || myCourse.description!.isEmpty){
      inputValidations['descirpton'] = 'description can`t be empty';
    }
    if(myCourse.categoryCode == null || myCourse.categoryCode!.isEmpty){
      inputValidations['categoryCode'] = 'category can`t be empty';
    }
    return inputValidations;
  }
}
