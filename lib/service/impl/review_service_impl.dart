
import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/review.dart';
import 'package:oqy/service/review_service.dart';

class ReviewServiceImpl extends ReviewService {
  final url = ApiConstants.reviews;
  final Dio dio;

  ReviewServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<List<Review>> findReviewsByCourseId(int id) async {
    Response response = await dio.get('$url/course-id/$id');
    try {
      List<Review> reviews =(response.data as List)
          .map((courseJson) => Review.fromJson(courseJson))
          .toList();
      return reviews;
    } catch (e) {
      throw  Exception();
    }
  }
  
  @override
  Future<List<Review>> create(Review review) async {
    try {
      Response response = await dio.post(url, data: review.toJson());
      List<Review> reviews =(response.data as List)
          .map((courseJson) => Review.fromJson(courseJson))
          .toList();
      return reviews;
    } catch (e) {
      throw  Exception(e);
    }
  }

}