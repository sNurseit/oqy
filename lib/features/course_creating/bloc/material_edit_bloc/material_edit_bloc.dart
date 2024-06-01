import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/service/material_service.dart';

part 'material_edit_event.dart';
part 'material_edit_state.dart';

class MaterialEditBloc extends Bloc<MaterialEditEvent, MaterialEditState> {

  MaterialService materialService;
  MaterialEntity? material;

  MaterialEditBloc({required this.materialService}) : super(MaterialEditInitial()) {
    on<LoadMaterialEdit>((event,emit) async {
      try{
        emit(MaterialEditLoading());
        material = await materialService.findById(event.id);
        emit(MaterialEditLoaded(material: material!));
      } catch(e){
        emit(MaterialLoadingError(e.toString()));
      } finally{
        event.completer?.complete();
      }
    });
  }
}
