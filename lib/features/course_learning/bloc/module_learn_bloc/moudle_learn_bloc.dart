import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/dto/answered_dto.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/material_entity.dart';
import 'package:oqy/domain/entity/module.dart';
import 'package:oqy/domain/entity/quiz.dart';
import 'package:oqy/service/material_service.dart';
import 'package:oqy/service/module_service.dart';
import 'package:oqy/service/quiz_service.dart';

part 'moudle_learn_event.dart';
part 'moudle_learn_state.dart';

class ModuleLearnBloc extends Bloc<ModuleLearnEvent, ModuleLearnState> {
  
  List<MaterialEntity> materials = [];
  MaterialService materialService;
  QuizService quizService;
  ModuleService moduleServices;

  ModuleLearnBloc({required this.materialService, required this.moduleServices, required this.quizService}) : super(ModuleLearnInitial()) {
    on<LoadModuleLearn>((event, emit) async {
      try{
        emit(ModuleLearnLoading());
        if(event.module is Module ){
          final module = await moduleServices.findById(event.module.id!);
          materials = module.materials!;
          final index =event.materialIndex;
          if(materials[index].type == 'text'){
            emit(MaterialLearnLoaded(materials: materials, currentMaterial: materials[index]));
          } else{
            final video = await materialService.getVideo(materials[index].content!);
            emit(VideoLearnLoaded(materials: materials, currentMaterial: materials[index], video: video));
          }
        } else{
          final quiz = await quizService.findById(event.module.id!);
          
          emit(QuizLearnLoaded(quiz: quiz));
        }
      } catch(e) {
        emit(ModuleLearnLoadingError());
      } finally{
        event.completer?.complete();
      }
    });

    on<CheckQuiz>((event,emit) async{
      final points = await quizService.checkQuiz(event.quizId, event.answers);
      emit(QuizAnswered(points: points));
    });
  }
}
