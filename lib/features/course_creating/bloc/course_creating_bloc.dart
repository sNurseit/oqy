import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/course_category.dart';
import 'package:oqy/service/course_category_service.dart';
import 'package:oqy/service/course_service_impl.dart';

part 'course_creating_event.dart';
part 'course_creating_state.dart';

class CourseCreatingBloc extends Bloc<CourseCreatingEvent, CourseCreatingState> {
  CourseService courseService;
  CourseCategoryService courseCategoryService;
  Course? course;
  CourseCreatingBloc({required this.courseService, required this.courseCategoryService}) : super(CourseCreatingInitial()) {
    on<LoadCourseCreating>((event, emit) async {
      if(event.courseId != null && event.courseId! > 0){
        try{
          emit(CourseCreatingLoading());
          course = await courseService.myCreatedCourse(event.courseId!);
          final List<CourseCategory> categoryList = await courseCategoryService.getAllCategories();
          emit(CourseCreatingLoaded(course: course, category: categoryList));
        } catch(e){
          emit(CourseCreatingError('Something went wrong, please try again'));
        } finally{
          event.completer?.complete();
        }
      } else{
        final List<CourseCategory> categoryList = await courseCategoryService.getAllCategories();
        emit(CourseCreatingLoaded(course: course, category: categoryList));
      }
    });
    //------------------Course Category--------------------------------//
    on<LoadCourseCategory>((event,emit) async{
      try{
        emit(CourseCategoryLoading());
        final List<CourseCategory> categoryList = await courseCategoryService.getAllCategories();
        emit(CourseCategoryLoaded(categoryList));
      } catch (e) {
        emit(CourseCategoryError('Something went wrong, please try again'));
      } finally{
        event.completer?.complete();
      }
    });

    on<PostCourseMainInformation>((event, emit) async{
      Map<String,String> validatedInputs = validateInput(event.course);
      if(validatedInputs.isNotEmpty){
        emit(CourseCreatingErrorList(validatedInputs));
      } else {
        try {
          emit(CourseCreatingLoading());
          int status = await courseService.create(event.course);
          if(status >=200 && status < 300) {
            final List<CourseCategory> categoryList = await courseCategoryService.getAllCategories();
            emit(CourseCreatingLoaded(course: course, category: categoryList));
          }
        } catch (e){
          emit(CourseCreatingError('Something went wrong, please try again'));
        } finally{
          event.completer?.complete();
        }
      }
    });
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
