import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/module_item.dart';
import 'package:oqy/service/course_service/course_service.dart';




class CourseModel extends ChangeNotifier{
  int courseId;
  Course? _course;
  get course=>_course;

  List<ModuleItem>? _modules;
  get modules =>_modules;

  final _courseService = CourseService();
  

  CourseModel({required this.courseId}){
    setup();
  }

  Future<void> setup() async {
    _course = (await _courseService.getOneCourse(courseId));
    if (_course != null && _course!.modules != null) {
      _modules = List.generate(
        _course!.modules!.length,
        (int index) => ModuleItem(module: _course!.modules![index]),
      );
    }
    notifyListeners();
  }

  void expand(int index) {
    if (_modules != null && index >= 0 && index < _modules!.length) {
      _modules![index].isExpanded = !_modules![index].isExpanded ;
      notifyListeners();
    }
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
  bool updateShouldNotify(CourseProvider old) => old != child;
}