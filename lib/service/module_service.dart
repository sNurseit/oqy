

import 'package:oqy/domain/entity/module.dart';

abstract class ModuleService{
  Future<Module> findById(int id);
  Future<Module> update(Module module);
  Future<void> deleteById(int id);
  Future<Module> create(Module module);
}