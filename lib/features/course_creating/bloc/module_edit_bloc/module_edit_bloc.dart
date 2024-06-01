import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/material_service.dart';
import 'package:oqy/service/module_service.dart';

part 'module_edit_event.dart';
part 'module_edit_state.dart';

class ModuleEditBloc extends Bloc<ModuleEditEvent, ModuleEditState> {
  ModuleService moduleService;
  MaterialService materialService;
  bool changed = false;
  Module? module;

  ModuleEditBloc({required this.moduleService, required this.materialService}) : super(ModuleEditInitial())  {
    on<LoadModuleEdit>((event, emit) async {
      try{
        emit(ModuleEditLoading());
        module = await moduleService.findById(event.moduleId);
        emit(ModuleEditLoaded(module: module!));
      } catch(e){
        ModuleEditError(errorMessage: e.toString());
      }
    });

    on<DeleteMaterial>((event, emit) async {
      try{
        emit(ModuleEditLoading());
        await materialService.deleteById(event.materialId);
        module?.removeMaterialById(event.materialId);
        emit(ModuleEditLoaded(module: module!));
      } catch(e){
        ModuleEditError(errorMessage: e.toString());
      }
    });

    on<AddMaterial>((event,emit) async {
      try{
        emit(ModuleEditLoading());
        if(event.material.id !=null){
          final material = await materialService.update(event.material);
          module!.updateMaterialById(material);
        }else{
          final material = event.material;
          if(module!.materials != null){
            material.step = getMaxStep(module!.materials!);
          } else{
            material.step = 1;
          }
          module!.materials!.add(await materialService.create(material));
        }
        emit(ModuleEditLoaded(module: module!));
      } catch(e){
        ModuleEditError(errorMessage: e.toString());
      }
    });

    on<NavigateToMyMaterial>((event,emit){
      try{
        AutoRouter.of(event.context).push(MaterialEditRoute(materialStep: event.materialId, moduleStep: module!.step));
      } catch(e){
        emit(ModuleEditLoaded(module: module!));
      }
    });

  }
  int getMaxStep(List<dynamic> items) {
    if (items.isEmpty) {
      return 0;
    }
    return items.map((item) => item.step).reduce((a, b) => a > b ? a : b);
  }
}
