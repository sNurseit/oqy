import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'moderator_event.dart';
part 'moderator_state.dart';

class ModeratorBloc extends Bloc<ModeratorEvent, ModeratorState> {
  ModeratorBloc() : super(ModeratorInitial()) {
    on<ModeratorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
