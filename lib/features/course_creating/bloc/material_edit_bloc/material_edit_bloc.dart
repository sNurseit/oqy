import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'material_edit_event.dart';
part 'material_edit_state.dart';

class MaterialEditBloc extends Bloc<MaterialEditEvent, MaterialEditState> {
  MaterialEditBloc() : super(MaterialEditInitial()) {
    on<MaterialEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
