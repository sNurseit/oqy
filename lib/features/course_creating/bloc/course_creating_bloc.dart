import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/course_category.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/domain/entity/online_lesson.dart';
import 'package:oqy/domain/entity/quiz.dart';
import 'package:oqy/service/course_category_service.dart';
import 'package:oqy/service/course_service_impl.dart';

part 'course_creating_event.dart';
part 'course_creating_state.dart';

class CourseCreatingBloc extends Bloc<CourseCreatingEvent, CourseCreatingState> {
  CourseService courseService;
  CourseCategoryService courseCategoryService;
  Course course = Course.empty();
  List<CourseCategory>? categoryList;
  List<ModuleType> courseModules = [];

  CourseCreatingBloc({
    required this.courseService, 
    required this.courseCategoryService
  }) : super(CourseCreatingInitial()) {

    on<LoadCourseCreating>((event, emit) async {
      if(event.courseId != null && event.courseId! > 0){
        try{
          if(event.completer==null){
            emit(CourseCreatingLoading());
          }
          course = await courseService.myCreatedCourse(event.courseId!);
          categoryList = await courseCategoryService.getAllCategories();
          updateModules(course.modules!, course.quizzes!);
          emit(CourseCreatingLoaded(course: course, category: categoryList!, courseModules:courseModules)); 
        } catch(e){
          print(e.toString());
          emit(CourseCategoryError(e.toString()));
        } finally{
          event.completer?.complete();
        }
      } else{
        emit(CourseCreatingLoading());
        final List<CourseCategory> categoryList = await courseCategoryService.getAllCategories();
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
        emit(CourseCategoryError(e.toString()));
      } finally{
        event.completer?.complete();
      }
    });

    on<ChangeModuleStep>((event, emit) {
      emit(CourseCreatingLoading());
      print('changing this shit');
      List<ModuleType> moduleTypes = event.moduleTypes;
      List<Module> modules = [];
      List<Quiz> quizzes = [];
      int step = 1;
      
      moduleTypes.forEach((moduleType) {
        if (moduleType.type == 'module') {
          Module? module = getModuleByStep(moduleType.step);
          if (module != null) {
            module.step = step;
            modules.add(module);
          }
        } else {
          Quiz? quiz = getQuizByStep(moduleType.step);
          if (quiz != null) {
            quiz.step = step;
            quizzes.add(quiz);
          }
        }
        step++;
      });

      course.modules = modules;
      course.quizzes = quizzes;

      emit(CourseCreatingLoaded(
        course: course,
        category: categoryList!,
        courseModules: moduleTypes,
      ));
    });
    on<AddModule>((event, emit){
      final title = event.title;
      final description = event.description;
      Map<String,String> validatedInputs = validateModuleInputs(event.title, event.description, event.type);
      if(validatedInputs.isNotEmpty){
        emit(CourseCreatingErrorList(validatedInputs));
      } else{
        int totalStep = course.quizzes!.length + course.modules!.length+1;
        switch(event.type){
          case 0:
            course.modules!.add(
              Module(
                title: title,
                description:description,
                step:totalStep+1,
              )
            );
            break;
          case 1:
            course.quizzes!.add(
              Quiz(
                title: title,
                instruction:description,
                step:totalStep+1,
              )
            );
            break;
          case 2:
            course.onlineLessons!.add(
              OnlineLesson(
                title: title,
                description: description
              )
            );
            break;
        }
        updateModules(course.modules!, course.quizzes!);
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
          emit(CourseCreatingError(e.toString()));
        } finally{
          event.completer?.complete();
        }
      }
    });
  }

  Module? getModuleByStep(int step) {
    return course.modules?.firstWhere((module) => module.step == step, );
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
            title: modules[moduleId].title!,
            step: modules[moduleId].step!,
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
            title: quizes[quizId].title!,
            step: quizes[quizId].step!,
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
