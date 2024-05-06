import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/material.dart';
import 'package:oqy/service/course_service_impl.dart';

class MyTrainingModel extends ChangeNotifier {
  int courseId;
  Course? _course;
  int moduleId = 0;
  MaterialEntity? materials;
  get course=>_course;
  final _courseService = CourseService();

  MyTrainingModel({required this.courseId}){
    _setup();
  }

  void _setup() async{
    _course = await _courseService.getOneTraining(courseId);
    print(_course?.title);
    notifyListeners();
  }
}