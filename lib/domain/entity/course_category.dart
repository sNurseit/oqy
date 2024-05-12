class CourseCategory{
  String? code;
  String? nameKk;
  String? nameRu;
  String? nameEn;

  CourseCategory({
    required this.code,
    required this.nameKk,
    required this.nameRu,
    required this.nameEn,
  });

  factory CourseCategory.fromJson(Map<String, dynamic> json) {
    return CourseCategory(
      code: json['code'],
      nameKk: json['nameKk'],
      nameRu: json['nameRu'],
      nameEn: json['nameEn'],
    );
  }
}