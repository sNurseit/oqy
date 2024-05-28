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
        await materialService.deleteById(event.materialId);
        module?.removeMaterialById(event.materialId);
        emit(ModuleEditLoaded(module: module!));
      } catch(e){
        ModuleEditError(errorMessage: e.toString());
      }
    });

    on<AddMaterial>((event,emit) async {
      try{
        final material = await materialService.create(event.material);
        module!.materials!.add(material);
        emit(ModuleEditLoaded(module: module!));
      } catch(e){
        ModuleEditError(errorMessage: e.toString());
      }
    });

    on<UpdateMaterial>((event,emit) async {
      try{
        final material = await materialService.update(event.material);
        module!.updateMaterialById(material);
        emit(ModuleEditLoaded(module: module!));
      } catch(e){
        ModuleEditError(errorMessage: e.toString());
      }
    });

    on<NavigateToMaterial>((event,emit){
      AutoRouter.of(event.context).push(MaterialEditRoute(materialStep: event.materialId, moduleStep: module!.step));
    });
  }
}
