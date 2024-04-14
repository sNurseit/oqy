import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_service/course_service.dart';

class TrainingModel extends ChangeNotifier {
  final _courseService =CourseService();
  List<Course> _courses = [];
  get courses=>_courses;

  TrainingModel(){
    getTrainingCourses();
  }
  Future<void> getTrainingCourses()async {
    _courses = (await _courseService.myTraining())!;
    notifyListeners();
  }

  void navigateToCourseTraining (BuildContext context, int index) {
    AutoRouter.of(context).push( MyTrainingRoute(courseId: index));
  }
  
}

