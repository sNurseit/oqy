

import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/service/material_service.dart';

class MaterialServiceImpl extends MaterialService{
  final url = ApiConstants.getModule;
  final Dio dio;

  MaterialServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<MaterialEntity> create(MaterialEntity material) async {
    try {
      Response response = await dio.post(url, data: material);
      return MaterialEntity.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try {
      dio.delete('$url/$id');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<MaterialEntity> findById(int id) async {
    try {
      Response response = await dio.get('$url/$id');
      return MaterialEntity.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<MaterialEntity> update(MaterialEntity material) async {
    try {
      Response response = await dio.put('$url/${material.id}', data: material);
      return MaterialEntity.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

}