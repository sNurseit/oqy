
import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/answer.dart';
import 'package:oqy/service/answer_service.dart';

class AnswerServiceImpl extends AnswerService{

  final String url = ApiConstants.question;
  final Dio dio;

  AnswerServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Answer> create(Answer answer) async {
    try{
      Response response = await dio.post(url, data: answer.toJson());
      return Answer.fromJson(response.data);
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
  Future<Answer> findById(int id) async {
    try{
      Response response = await dio.get('$url/$id');
      return  Answer.fromJson(response.data);
    } catch(e){
      throw Exception();
    }  
  }

  @override
  Future<Answer> update(Answer answer) async{
    try{
      Response response = await dio.put('$url/${answer.id}', data: answer.toJson());
      return  Answer.fromJson(response.data);
    } catch(e){
      throw Exception();
    }
  }

}