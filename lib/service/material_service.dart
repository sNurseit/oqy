
import 'dart:io';

import 'package:oqy/domain/entity/material_entity.dart';

abstract class MaterialService{
  Future<MaterialEntity> findById(int id);
  Future<void> deleteById(int id);
  Future<MaterialEntity> create(MaterialEntity material);
  Future<MaterialEntity> update(MaterialEntity material);
  Future<String> uploadVideo(File videoFile);
}