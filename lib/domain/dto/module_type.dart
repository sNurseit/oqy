class ModuleType{
  final id;
  String type;
  String title;
  int step;
  String? uuid;
  ModuleType({required this.id, required this.type, required this.title, required this.step, }){
    this.uuid = '$id-$type-$step';
  }
}


abstract class StepItem {
  int? get id;
  int get step;
  String get title;
  String? get description;
}
