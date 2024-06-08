part of 'moudle_learn_bloc.dart';

abstract class ModuleLearnEvent extends Equatable{}

class LoadModuleLearn extends ModuleLearnEvent{
  final StepItem module;
  final int materialIndex;
  final Completer? completer;

  LoadModuleLearn({required this.materialIndex, required this.module, this.completer});

  @override
  List<Object?> get props => [module, completer, materialIndex];
}


class CheckQuiz extends ModuleLearnEvent{
  final int quizId;
  final List<AnsweredDto> answers;
  final BuildContext context;

  CheckQuiz({required this.quizId, required this.answers, required this.context});
  
  @override
  List<Object?> get props => [answers, context]; 
}


class NavigateMaterial extends ModuleLearnEvent{
  
  @override
  List<Object?> get props =>[];
}