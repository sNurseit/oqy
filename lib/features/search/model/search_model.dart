import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_service/course_service.dart';

class SearchModel extends ChangeNotifier {
  String? text;
  final searchTextController =TextEditingController();
  final _courseService = CourseService();
  List<Course> courses = [];

  SearchModel() {
    searchTextController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    search();
  }
  Future<void> search() async {
    if(searchTextController.text.isNotEmpty){
      courses = (await _courseService.searchCourses(searchTextController.text))!;
      notifyListeners();
    }
  }
  
  Future<void> navigateToCourseDetails (BuildContext context, int? index) async {
    if (index != null){
      print(index);
      AutoRouter.of(context).push(CourseRoute(courseId: index));
    }
  }

}