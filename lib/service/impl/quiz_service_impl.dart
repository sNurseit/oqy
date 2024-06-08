
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/dto/answered_dto.dart';
import 'package:oqy/domain/entity/quiz.dart';
import 'package:oqy/service/quiz_service.dart';

class QuizServiceImpl extends QuizService {

  String url = ApiConstants.quiz;
  Dio dio;

  QuizServiceImpl({required  this.dio}){
    dio.interceptors.add(AuthInterceptor());
    dio.options.headers['Content-Type'] = 'application/json';
  }

  @override
  Future<Quiz> create(Quiz quiz) async {
    try{
      final request = jsonEncode(quiz.toJson());
      int contentLength = utf8.encode(request).length;
      Response response = await dio.post(
        url, data: request,
        options: Options(
          headers: {
            'Content-Length': contentLength.toString(),
          },
        ),
      );
      return Quiz.fromJson(response.data);
    } catch(e){
      throw Exception(e.toString());
    }   
  }

  @override
  Future<void> deleteById(int id) async {
    try{
      await dio.delete('$url/$id');
    } catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<Quiz> findById(int id) async {
    try{
      Response response = await dio.get('$url/$id');
      return Quiz.fromJson(response.data);
    } catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<Quiz> update(Quiz quiz) async {
    try{
      Response response = await dio.put('$url/${quiz.id}', data: quiz.toJson());
      return Quiz.fromJson(response.data);
    } catch(e){
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<List<Quiz>> findAllByCourseId(int courseId) async {
    try{
      Response response = await dio.get('$url/course/$courseId');
      List<Quiz> quizzes = (response.data as List)
          .map((quiz) => Quiz.fromJson(quiz))
          .toList();
      return quizzes;
    } catch(e){
      throw Exception(e.toString());
    }
  }

  @override
  Future<int> checkQuiz(int quizId, List<AnsweredDto> answers) async {
    try{
      Response response = await dio.post(
        '$url/answered/$quizId', 
        data: answers.map((answer) => answer.toJson()).toList()
      );
      return response.data as int;
    } catch(e){
      throw Exception(e.toString());
    }
  }


}