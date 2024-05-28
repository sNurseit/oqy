
import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/service/module_service.dart';

class ModuleServiceImpl extends ModuleService{
  final getModuleUrl = ApiConstants.getModule;
  static const url = ApiConstants.module;
  final Dio dio;

  ModuleServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
    dio.options.headers['Content-Type'] = 'application/json';
  }

  @override
  Future<Module> findById(int id) async {
    try{
      Response response = await dio.get('$getModuleUrl/$id');
      return  Module.fromJson(response.data);
    } catch(e){
      print(e.toString());
      throw Exception(e);
    }
  }
  
  @override
  Future<Module> create(Module module) async {
    try{
      Response response = await dio.post(url, data: module);
      return  Module.fromJson(response.data);
    } catch(e){
      throw Exception(e);
    }
  }
  
  @override
  Future<void> deleteById(int id) async {
    try{
      await dio.delete('$url/$id');
    } catch(e){
      throw Exception(e);
    }
  }
  
  @override
  Future<Module> update(Module module) async {
    try{
      Response response = await dio.put(url, data: module);
      return  Module.fromJson(response.data);
    } catch(e){
      throw Exception(e);
    }
  }
}