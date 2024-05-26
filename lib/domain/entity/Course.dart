import 'dart:convert';

import 'package:oqy/domain/entity/online_lesson.dart';
import 'package:oqy/domain/entity/quiz.dart';

import 'module.dart';

class Course {
  int?  id;
  String? title;
  String? description;
  String? language;
  String? price;
  List<Module>? modules =[];
  List<OnlineLesson>? onlineLessons =[];
  List<Quiz>? quizzes =[];
  int? moduleCount;
  int? materialCount;
  int? quizCount;
  double?  averageRating;
  int? enrollmentCount;
  int? reviewCount;
  String? categoryCode;
  List<int>? imageBytes;
  String? image;
  Course({
    this.id,
    this.title,
    this.description,
    this.language,
    this.price,
    this.modules,
    this.onlineLessons,
    this.quizzes,
    this.moduleCount,
    this.materialCount,
    this.quizCount,
    this.averageRating,
    this.enrollmentCount,
    this.reviewCount,
    this.imageBytes,
    this.categoryCode,
    this.image,
  });

  factory Course.empty(){
    return Course(
      modules: [],
      quizzes: [],
      onlineLessons: [],
    );
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    String pic;
    if (json['coursePicture'] != null && json['coursePicture'].isNotEmpty) {
      pic = json['coursePicture'].split(",")[1];
    } else {
      pic ="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";
    }

    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      language: json['language'],
      price: json['price'],
      modules: json['modules']!=null 
        ? List<Module>.from(json['modules'].map((module) => Module.fromJson(module))): [],
      onlineLessons: json['onlineLessons']!=null 
        ? List<OnlineLesson>.from(json['onlineLessons'].map((module) => Module.fromJson(module))): [],
      quizzes: json['quizes']!=null
        ? List<Quiz>.from(json['quizes'].map((module) => Module.fromJson(module))) : [],
      moduleCount: json['moduleCount'],
      materialCount: json['materialCount'],
      quizCount: json['quizCount'],
      averageRating: json['averageRating'].toDouble(),
      enrollmentCount: json['enrollmentCount'],
      reviewCount: json['reviewCount'],
      categoryCode: json['categoryCode'],
      imageBytes: base64.decode(pic),
      image: null,
    );
  }

  Map<String,dynamic> toJson(){
    if (image != null){
      image = 'data:image/png;base64,$image';
    }
    return {
      'id': id,
      'title': title,
      'description': description,
      'language': language,
      'price': price,
      'modules': modules!=null ? modules!.map((module) => module.toJson()).toList(): [],
      'onlineLessons': onlineLessons!=null ? onlineLessons!.map((onlineLesson) => onlineLesson.toJson()).toList(): [],
      'quizzes': quizzes!=null ? quizzes!.map((quiz) => quiz.toJson()).toList():[],
      'averageRating': averageRating,
      'enrollmentCount': enrollmentCount,
      'reviewCount': reviewCount,
      'categoryCode': categoryCode,
      'coursePicture': image,
    };
  }

}