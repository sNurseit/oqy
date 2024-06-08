import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_service_impl.dart';

class HomeModel extends ChangeNotifier {
  final _courseService =CourseService();
  List<Course> _model = [];
  get model=>_model;

  List<Course> _topCourses = [];
  get topCourses=>_topCourses;

  HomeModel(){
    getAllCourses();
   // getTopTen();
  }
  Future<void> getAllCourses()async {
    _topCourses = (await _courseService.getAllCourses())!;
    notifyListeners();
  }
  Future<void> getTopTen()async {
    _topCourses = (await _courseService.topTen())!;
    notifyListeners();
  }

  void navigateToCourseDetails (BuildContext context, int id) {
    AutoRouter.of(context).push(CourseRoute(courseId: id));
  }

}