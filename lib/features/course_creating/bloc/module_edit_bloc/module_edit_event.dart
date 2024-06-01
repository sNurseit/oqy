part of 'module_edit_bloc.dart';


abstract class ModuleEditEvent extends Equatable{}

class LoadModuleEdit extends ModuleEditEvent{
  final int moduleId;
  final Completer? completer;

  LoadModuleEdit({required this.moduleId, this.completer});
  @override
  List<Object?> get props => [moduleId, completer];
}

class NavigateToMyMaterial extends ModuleEditEvent {
  final BuildContext context;
  final int materialId;

  NavigateToMyMaterial({required this.context, required this.materialId});
  @override
  List<Object?> get props => [context, materialId];
}

class OpenBottomSheet extends ModuleEditEvent{
  final BuildContext context;
  OpenBottomSheet({required this.context});
  @override
  List<Object?> get props => [];
}

class AddMaterial extends ModuleEditEvent {
  final MaterialEntity material;

  AddMaterial({required this.material});
  @override
  List<Object?> get props => [material];
}

class DeleteMaterial extends ModuleEditEvent {
  final int materialId;

  DeleteMaterial({required this.materialId});
  @override
  List<Object?> get props => [materialId];
}

class UpdateMaterial extends ModuleEditEvent{
  final BuildContext context;
  final MaterialEntity material;

  UpdateMaterial({required this.context, required this.material});
  @override
  List<Object?> get props => [context, material];
}