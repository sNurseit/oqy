part of 'moudle_learn_bloc.dart';

abstract class ModuleLearnState extends Equatable {}

final class ModuleLearnInitial extends ModuleLearnState {
  @override
  List<Object?> get props => [];
}

final class MaterialLearnLoaded extends ModuleLearnState {
  final List<MaterialEntity> materials;
  final MaterialEntity currentMaterial;
  MaterialLearnLoaded({required this.materials, required this.currentMaterial});

  @override
  List<Object?> get props => [materials, currentMaterial];
}

final class VideoLearnLoaded extends ModuleLearnState{
  final List<MaterialEntity> materials;
  final MaterialEntity currentMaterial;
  final String video;
  VideoLearnLoaded({required this.materials, required this.currentMaterial, required this.video});
  @override
  List<Object?> get props => [];
}

final class QuizLearnLoaded extends ModuleLearnState {  
  final Quiz quiz;

  QuizLearnLoaded({required this.quiz});

  @override
  List<Object?> get props => [];
}


final class QuizAnswered extends ModuleLearnState{
  final int points;
  QuizAnswered({required this.points});
  @override
  List<Object?> get props => [points];
}

final class ModuleLearnLoading extends ModuleLearnState{
  @override
  List<Object?> get props => [];
}

final class ModuleLearnLoadingError extends ModuleLearnState{
  @override
  List<Object?> get props => [];
}