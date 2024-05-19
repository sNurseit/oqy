import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/oqy_app.dart';
import 'package:oqy/service/course_category_service.dart';
import 'package:oqy/service/course_service_impl.dart';
import 'package:oqy/service/impl/course_category_service_impl.dart';
import 'package:oqy/service/impl/profile_service_impl.dart';
import 'package:oqy/service/impl/review_service_impl.dart';
import 'package:oqy/service/profile_service.dart';
import 'package:oqy/service/review_service.dart';

void main() {
  GetIt.I.registerLazySingleton<ProfileService>(
    ()=>ProfileServiceImpl(dio: Dio())
  );
  GetIt.I.registerLazySingleton<CourseCategoryService>(
    ()=>CourseCategoryServiceImpl(dio: Dio())
  );
  GetIt.I.registerLazySingleton<ReviewService>(
    ()=>ReviewServiceImpl(dio: Dio())
  );
  GetIt.I.registerLazySingleton<CourseService>(()=>CourseService());

  runApp(const OqyApp());
}
