
import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/course.dart';

class CourseService {
    final Dio _dio = Dio();
    final String GET_ALL_COURSES = ApiConstants.GET_ALL_COURSES;
    final String GET_ONE_COURSE = ApiConstants.GET_ONE_COURSE;
    final String buy = ApiConstants.buyCourse;
    final String search = ApiConstants.search;
    final String trainingCourse = ApiConstants.myTraining;

  CourseService(){
    _dio.interceptors.add(AuthInterceptor());
  }
    Future<List<Course>?> getAllCourses() async {
        try {
            Response response = await _dio.get(GET_ALL_COURSES);
            if (response.statusCode == 200) {
                List<Course> courses = (response.data['content'] as List)
                    .map((courseJson) => Course.fromJson(courseJson))
                    .toList();
                return courses;
            } else {
                throw Exception('Failed to load content. Status code: ${response.statusCode}');
            }
        } catch (error) {
            throw Exception('Failed to make the request: $error');
        }
    }

    Future<Course> getOneCourse(int courseId) async {

        try {
            Response response = await _dio.get('$GET_ONE_COURSE/$courseId');
            if (response.statusCode == 200) {
                Course course = Course.fromJson(response.data);
                return course;
            } else {
                throw Exception('Failed to load content. Status code: ${response.statusCode}');
            }
        } catch (error) {
            throw Exception('Failed to make the request: $error');
        }
    }

  Future<List<Course>?> searchCourses(String title) async {
    try {
      Response response = await _dio.get('${search}?title=${title}');
      if (response.statusCode == 200) {
        List<Course> courses = (response.data['content'] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
        return courses;
      } 
      else {
        throw Exception('Failed to load content. Status code: ${response.statusCode}');
      }
    } 
    catch (error) {
      throw Exception('Failed to make the request: $error');
    }
  }
  
  Future<int?> buyCourse(int courseId) async{

    try {
      final response = await _dio.post(
        buy,
        data: {'courseId': courseId}
      );       
      return response.statusCode ;
    } 
    catch (error) {
      throw Exception('Failed to make the request: $error');
    }
  }

  Future<Course> getOneTraining(int courseId) async {
    try {
      Response response = await _dio.get('$trainingCourse/$courseId');
        if (response.statusCode == 200) {
          Course course = Course.fromJson(response.data);
            return course;
        } else {
            throw Exception('Failed to load content. Status code: ${response.statusCode}');
        }
    } catch (error) {
        throw Exception('Failed to make the request: $error');
    }
  }
  Future<List<Course>?> myTraining() async{
    try {
      Response response = await _dio.get(trainingCourse);
      if (response.statusCode == 200) {
        List<Course> courses = (response.data['content'] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
        return courses;
      } 
      else {
        throw Exception('Failed to load content. Status code: ${response.statusCode}');
      }
    } 
    catch (error) {
      throw Exception('Failed to make the request: $error');
    }
  }

  Future<List<Course>?> myCourses() async{
    try {
      Response response = await _dio.get(trainingCourse);
      if (response.statusCode == 200) {
        List<Course> courses = (response.data['content'] as List)
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
        return courses;
      } 
      else {
        throw Exception('Failed to load content. Status code: ${response.statusCode}');
      }
    } 
    catch (error) {
      throw Exception('Failed to make the request: $error');
    }
  }
   
}