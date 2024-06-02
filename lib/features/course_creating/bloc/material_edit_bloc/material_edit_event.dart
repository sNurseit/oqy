part of 'material_edit_bloc.dart';

abstract class MaterialEditEvent extends Equatable{}

class LoadMaterialEdit extends MaterialEditEvent{
  final Completer? completer;
  final int id;
  final int moduleId;

  LoadMaterialEdit({required this.id, required this.moduleId, this.completer});
  @override
  List<Object?> get props => [completer,id,moduleId];
}

class UploadVideo extends MaterialEditEvent{
  final Completer? completer;
  final File videoFile;

  UploadVideo({required this.videoFile, this.completer});

  @override
  List<Object?> get props => [videoFile, completer];
}
