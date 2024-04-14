import 'package:oqy/domain/entity/material.dart';

class Module{
  final int id;
  final int courseId;
  final String title;
  final String description;
  final int? totalSteps;
  final List<MaterialEntity>? materials;

  Module({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.materials,
    this.totalSteps,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      totalSteps: json['totalSteps'],
      materials: json['materials'],
    );
  }
}