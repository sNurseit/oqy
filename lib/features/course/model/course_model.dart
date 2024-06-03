import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/domain/entity/course.dart';
import 'package:oqy/domain/entity/review.dart';
import 'package:oqy/domain/provider/session_provider.dart';
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

  List<Review> _reviews = [];
  get reviews=>_reviews;

  List<StepItem> _stepItems =[];
  get stepItems=>_stepItems;

  final _courseService = CourseService();
  final _reviewService = GetIt.I<ReviewService>();
  final _sessionProvider = SessionDataProvider();
  double userRating = 0.0;

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
      _stepItems = [...?course.modules ?? [], ...?course.quizzes ?? []];
      _stepItems.sort((a, b) => a.step.compareTo(b.step));
    }
    notifyListeners();
  }

  void updateUserRating(double newRating){
    userRating = newRating;
    notifyListeners();
  }
  
  Future<void> getReviews() async {
    _reviews = await _reviewService.findReviewsByCourseId(courseId);
    _reviews = _reviews.reversed.toList();
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

  Future<void> addReview(String text) async {
    final session =  await _sessionProvider.getSessions();
    final myReview = Review(userId: session.userId, courseId: courseId, review: text, rating: userRating.toInt() );
    _reviews= await _reviewService.create(myReview);
    _reviews = _reviews.reversed.toList();
    notifyListeners();
  }
}