import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/online_lesson.dart';

abstract class OnlineLessonService{
  Future<OnlineLesson> findById(int id);
}

class OnlineLessonServiceImpl extends OnlineLessonService{

  final String url = ApiConstants.lesson;
  final Dio dio;

  OnlineLessonServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<OnlineLesson> findById(int id) async {
    try{
      Response response = await dio.get('$url/$id');
      return  OnlineLesson.fromJson(response.data);
    } catch(e){
      throw Exception(e);
    }
  }

}