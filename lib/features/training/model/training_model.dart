import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_service_impl.dart';

class TrainingModel extends ChangeNotifier {
  final _courseService =CourseService();
  List<Course> _courses = [];
  get courses=>_courses;

  List<Course> _cretatedCourses =[];
  get createdCourses=>_cretatedCourses;

  TrainingModel(){
    getTrainingCourses();
    getCreatedCourses();
    notifyListeners();
  }

  Future<List<Course>> getTrainingCourses() async {
    _courses = (await _courseService.myTraining())!;
    return _courses;
  }

  Future<List<Course>> getCreatedCourses() async {
    _cretatedCourses = (await _courseService.myCreated())!;
    return _cretatedCourses;
  }

  void navigateToCourseTraining (BuildContext context, int index) {
    AutoRouter.of(context).push( MyLearningRoute(courseId: index));
  }

  void navigateTeCourseCreating(BuildContext context, int? index) {
    index ??= 0;
    AutoRouter.of(context).push(CourseCreatingRoute(courseId: index));
  }
  
}

