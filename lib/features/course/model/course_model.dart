import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/Course.dart';
import 'package:oqy/service/course_service/course_service.dart';

class CourseModel extends ChangeNotifier{
  int courseId;
  
  final _courseService = CourseService();
  Course? _course;
  get course=>_course;

  CourseModel({required this.courseId}){
    setup();
  }

  Future<void> setup() async {
    _course = (await _courseService.getOneCourse(courseId));
    print(_course?.price);
    notifyListeners();
  }

}

class CourseProvider extends InheritedNotifier {
  final CourseModel model;
  const CourseProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(child: child, notifier: model);

  static CourseProvider watch(BuildContext context) {
    final CourseProvider? result = context.dependOnInheritedWidgetOfExactType<CourseProvider>();
    assert(result != null, 'No GroupsWidgetModelProvider found in context');
    return result!;
  }

  static CourseProvider? read(BuildContext context){
    final widget = context
        .getElementForInheritedWidgetOfExactType<CourseProvider>()?.widget;
    return widget is CourseProvider? widget:null;
  }

  @override
  bool updateShouldNotify(CourseProvider old) {
    return true;
  }
}