

import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:oqy/domain/api_constant/api_constants.dart';
import 'package:oqy/domain/config/auth_config.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/service/material_service.dart';

class MaterialServiceImpl extends MaterialService{
  final url = ApiConstants.material;
  final fileUrl = ApiConstants.file;
  final Dio dio;

  MaterialServiceImpl({required this.dio}){
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<MaterialEntity> create(MaterialEntity material) async {
    try {
      Response response = await dio.post(url, data: material.toJson());
      return MaterialEntity.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteById(int id) async {
    try {
      dio.delete('$url/material/$id');
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
      Response response = await dio.put('$url/${material.id}', data: material.toJson());
      return MaterialEntity.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<String> uploadVideo(File videoFile) async {
    try {
      final fileName = path.basename(videoFile.path);
      
      final bytes = await videoFile.readAsBytes();
      final base64Video = base64Encode(bytes);
      
      // Формируем данные для отправки
      final formData = FormData.fromMap({
        'file': base64Video,
        'fileName': fileName,
      });
      
      Response response = await dio.post(fileUrl, data: formData);
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  Future<String> getVideo(String videoName) async {
    try {
      Response response = await dio.get('$fileUrl/download/$videoName');
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}