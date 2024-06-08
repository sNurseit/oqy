import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_service_impl.dart';

class TrainingModel extends ChangeNotifier {
  final _courseService =CourseService();
  int? createdCourseLength;
  List<Course> _courses = [];
  List<Course> archive = [];
  List<Course> active = [];
  List<Course> rejected = [];
  List<Course> not_checked = [];
  List<Course> re_check = [];

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

  Future<void> getCreatedCourses() async {
    _cretatedCourses = (await _courseService.myCreated())!;
    
    archive.clear();
    active.clear();
    rejected.clear();
    not_checked.clear();
    re_check.clear();

    for (var course in _cretatedCourses) {
      switch (course.status) {
        case 'ARCHIVE':
          archive.add(course);
          break;
        case 'ACTIVE':
          active.add(course);
          break;
        case 'REJECTED':
          rejected.add(course);
          break;
        case 'NOT_CHECKED':
          not_checked.add(course);
          break;
        case 'RE_CHECK':
          re_check.add(course);
          break;
        default:
          break;
      }
    }

    createdCourseLength = _cretatedCourses.length;
    notifyListeners();
  }

  void navigateToCourseTraining (BuildContext context, int index) {
    AutoRouter.of(context).push( MyLearningRoute(courseId: index));
  }

  void navigateToCourseCreating(BuildContext context, int? index) {
    index ??= 0;
    AutoRouter.of(context).push(CourseCreatingRoute(courseId: index));
  }
  
}

