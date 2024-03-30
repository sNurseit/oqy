import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_service/course_service.dart';

class HomeModel extends ChangeNotifier {
  final _courseService =CourseService();
  List<Course> _model = [];
  get model=>_model;

  HomeModel(){
    getAllCourses();
  }
  Future<void> getAllCourses()async {
    _model = (await _courseService.getAllCourses())!;
    notifyListeners();
  }

  void navigateToCourseDetails (BuildContext context, int index) {
    AutoRouter.of(context).push( CourseRoute(courseId: index));
  }

}