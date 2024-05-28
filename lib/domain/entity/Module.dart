import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/material_entity.dart';

class Module extends StepItem{
  @override
  int? id;
  int? courseId;
  @override
  String title;
  String? description;
  @override
  int step;
  int? totalSteps;
  List<MaterialEntity>? materials = [];

  Module({
    required this.id,
    this.courseId,
    required this.title,
    this.description,
    this.materials,
    required this.step,
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
      materials: json['materials']!=null
        ? List<MaterialEntity>.from(json['materials'].map((material) => MaterialEntity.fromJson(material))) : [],
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
      'materials': materialsJson ?? [],
      'moduleType':'module',
    };
  }

  void removeMaterialById(int materialId) {
    materials?.removeWhere((material) => material.id == materialId);
  }

  void updateMaterialById(MaterialEntity material) {
    if (materials != null) {
      for (int i = 0; i < materials!.length; i++) {
        if (materials![i].id == material.id) {
          materials![i] = material;
          break;
        }
      }
    }
  }
  
}