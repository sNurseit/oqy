
import 'package:oqy/domain/enums/material_type.dart';

class MaterialEntity{
  int? id;
  int? moduleId;
  String? title;
  String? content;
  MaterialType? type;

  MaterialEntity({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.content,
    required this.type
  });
  
  factory MaterialEntity.fromJson(Map<String, dynamic> json) {
    return MaterialEntity(
      id: json['id'],
      moduleId: json['moduleId'],
      title: json['title'],
      content: json['content'],
      type: json['type'],
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moduleId': moduleId,
      'title': title,
      'content': content,
      'type': type != null ? type.toString().split('.').last : null,
    };
  }

}