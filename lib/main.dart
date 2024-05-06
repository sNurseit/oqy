import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/oqy_app.dart';
import 'package:oqy/service/impl/profile_service_impl.dart';
import 'package:oqy/service/profile_service.dart';

void main() {
  GetIt.I.registerLazySingleton<ProfileService>(
    ()=>ProfileServiceImpl(dio: Dio())
  );
  
  runApp(const OqyApp());
}
