import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/oqy_app.dart';
import 'package:oqy/service/course_category_service.dart';
import 'package:oqy/service/course_service_impl.dart';
import 'package:oqy/service/impl/course_category_service_impl.dart';
import 'package:oqy/service/impl/material_service_impl.dart';
import 'package:oqy/service/impl/module_service_impl.dart';
import 'package:oqy/service/impl/profile_service_impl.dart';
import 'package:oqy/service/impl/quiz_service_impl.dart';
import 'package:oqy/service/impl/review_service_impl.dart';
import 'package:oqy/service/material_service.dart';
import 'package:oqy/service/module_service.dart';
import 'package:oqy/service/profile_service.dart';
import 'package:oqy/service/quiz_service.dart';
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
  GetIt.I.registerLazySingleton<ModuleService>(
    ()=>ModuleServiceImpl(dio: Dio())
  );
  GetIt.I.registerLazySingleton<MaterialService>(
    ()=>MaterialServiceImpl(dio: Dio())
  );
  GetIt.I.registerLazySingleton<QuizService>(
    ()=>QuizServiceImpl(dio: Dio())
  );
  GetIt.I.registerLazySingleton<CourseService>(()=>CourseService());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OqyApp());
}
