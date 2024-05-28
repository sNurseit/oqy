part of 'material_edit_bloc.dart';

sealed class MaterialEditState extends Equatable {
  const MaterialEditState();
  
  @override
  List<Object> get props => [];
}

final class MaterialEditInitial extends MaterialEditState {}
