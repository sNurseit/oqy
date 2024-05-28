class MaterialEntity {
  int? id;
  int? moduleId;
  String? title;
  int? step;
  String? content;
  String? type;

  MaterialEntity({
    this.id,
    this.moduleId,
    this.title,
    this.step,
    this.content,
    this.type,
  });

  factory MaterialEntity.fromJson(Map<String, dynamic> json) {
    return MaterialEntity(
      id: json['id'],
      moduleId: json['moduleId'],
      title: json['title'],
      step: json['step'],
      content: json['content'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moduleId': moduleId,
      'title': title,
      'step': step,
      'content': content,
      'type': type,
    };
  }
}
