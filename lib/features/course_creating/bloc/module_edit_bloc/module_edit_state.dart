part of 'module_edit_bloc.dart';

abstract class ModuleEditState extends Equatable {}
//-------------------Created Course------------------------//
final class ModuleEditInitial extends ModuleEditState {
  @override
  List<Object?> get props => [];
}
final class ModuleEditLoading extends ModuleEditState {
  @override
  List<Object?> get props => [];
}

final class ModuleEditLoaded extends ModuleEditState {
  final Module module;

  ModuleEditLoaded({required this.module});

  @override
  List<Object?> get props => [module];
}

final class ModuleEditError extends ModuleEditState {
  final String errorMessage;

  ModuleEditError({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}