import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/service/material_service.dart';
import 'package:path/path.dart' as path;

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

    on<UploadVideo>((event,emit) async {
      try{
        final fileName = path.basename(event.videoFile.path);
        final bytes = await event.videoFile.readAsBytes();
        final base64Video = base64Encode(bytes);
        material!.content = base64Video;
        emit(MaterialEditLoading());
        String content = await materialService.uploadVideo(event.videoFile);
        material!.content = content;
        emit(MaterialEditLoaded(material: material!));
      } catch(e){
        emit(MaterialLoadingError(e.toString()));
      } finally{
        event.completer?.complete();
      }
    });
  }
}
