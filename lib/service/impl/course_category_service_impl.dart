import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/course_category.dart';
import 'package:oqy/service/course_category_service.dart';

class CourseCategoryServiceImpl implements CourseCategoryService{
  final String url = ApiConstants.courseCategories;
  final Dio dio;
  CourseCategoryServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }
  @override
  Future<List<CourseCategory>> getAllCategories() async {
    Response response = await dio.get(url);
    try{        
      List<CourseCategory> courseCategories = (response.data as List)
        .map((courseJson) => CourseCategory.fromJson(courseJson))
        .toList();
      return courseCategories;
    } catch (e){
      throw  Exception(e);
    }
  }
}