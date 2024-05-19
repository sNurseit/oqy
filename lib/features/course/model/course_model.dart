import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/review.dart';
import 'package:oqy/service/course_service_impl.dart';
import 'package:oqy/service/review_service.dart';


class CourseModel extends ChangeNotifier{
  int courseId;

  Course? _course;
  get course=>_course;

  List<Module>? _modules;
  get modules =>_modules;

  String _errorText = "";
  get errorText=>_errorText;

  List<Review>? _reviews;
  get reviews=>_reviews;

  
  final _courseService = CourseService();
  final _reviewService = GetIt.I<ReviewService>();
  CourseModel({required this.courseId}){
    setup();
    getReviews();
  }

  Future<void> setup() async {
    _course = (await _courseService.getOneCourse(courseId));
    if (_course != null && _course!.modules != null) {
      _modules = List.generate(
        _course!.modules!.length,
        (int index) => _course!.modules![index],
      );
    }
    notifyListeners();
  }

  Future<void> getReviews() async {
    _reviews = await _reviewService.findReviewsByCourseId(courseId);
    notifyListeners();
  }

  Future<void> buyCourse(int courseId, BuildContext context)async {
    await _courseService.buyCourse(courseId)
      .then((status) {
        if (status! >= 200 && status < 300) {
          _errorText = "Successfully logged in";
          print(_errorText);
        } 
        else if (status >= 400 && status < 500) {
          _errorText = "Login or password is incorrect";
          print(_errorText);
        } 
        else {
          _errorText = "Problems in server, please try again after 5 minutes";
          print(_errorText);
        }
      });
  }
}