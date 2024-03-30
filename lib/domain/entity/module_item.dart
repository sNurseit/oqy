import 'package:oqy/domain/entity/Module.dart';

class ModuleItem{
  ModuleItem({
    this.isExpanded = false,
    required this.module,
  });
  bool isExpanded;
  Module module;
}