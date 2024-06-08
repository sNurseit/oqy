

import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/question.dart';
import 'package:oqy/service/question_service.dart';

class QuestionServiceImpl extends QuestionService{

  final String url = ApiConstants.question;
  final Dio dio;

  QuestionServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override 
  Future<List<Question>> findAllByQuizId(int quizId) async {
    try{
      Response response = await dio.get('$url/quiz/$quizId');
      return response.data !=null ? List<Question>.from(response.data.map((question) => Question.fromJson(question))) : [];
    } catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<Question> create(Question module) async {
    try{
      Response response = await dio.post(url, data: module.toJson());
      return Question.fromJson(response.data);
    } catch(e){
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try{
      await dio.delete('$url/$id');
    } catch(e){
      throw Exception();
    }
  }

  @override
  Future<Question> findById(int id) async {
    try{
      Response response = await dio.get('$url/$id');
      return  Question.fromJson(response.data);
    } catch(e){
      throw Exception();
    }  
  }

  @override
  Future<Question> update(Question module) async{
    try{
      Response response = await dio.put('$url/${module.id}', data: module.toJson());
      return  Question.fromJson(response.data);
    } catch(e){
      throw Exception();
    }
  }
}