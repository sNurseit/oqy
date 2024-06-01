part of 'material_edit_bloc.dart';

abstract class MaterialEditState extends Equatable {}

final class MaterialEditInitial extends MaterialEditState {
  @override
  List<Object?> get props =>[];
}

final class MaterialEditLoading extends MaterialEditState {
  @override
  List<Object?> get props => [];
}

final class MaterialEditLoaded extends MaterialEditState {
  final MaterialEntity material;
  MaterialEditLoaded({required this.material});
  @override
  List<Object?> get props => [material];
}

final class  MaterialLoadingError extends MaterialEditState {
  final String message;
  MaterialLoadingError(this.message);
  @override
  List<Object?> get props => [message];
}