import 'package:oqy/domain/entity/material.dart';

class Module{
  int? id;
  int? courseId;
  String? title;
  String? description;
  int? step;
  int? totalSteps;
  List<MaterialEntity>? materials;

  Module({
    this.id,
    this.courseId,
    this.title,
    this.description,
    this.materials,
    this.step,
    this.totalSteps,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      step: json['step'],
      totalSteps: json['totalSteps'],
      materials: json['materials'],
    );
  }
  
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? materialsJson;
    if (materials != null) {
      materialsJson = materials!.map((material) => material.toJson()).toList();
    }
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'totalSteps': totalSteps,
      'step': step,
      'materials': materialsJson,
    };
  }
}