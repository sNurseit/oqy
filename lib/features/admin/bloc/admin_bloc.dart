import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oqy/domain/dto/user_change_dto.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/service/impl/auth_service_impl.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AuthService authService;
  AdminBloc({required this.authService}) : super(AdminInitial()) {
    on<LoadAdminEvent>((event, emit) async {
      try{  
        emit(AdminLoading());
        final users = await authService.findUsersForAdmin();
        emit(AdminLoaded(users: users));
      }catch(e){
        print(e.toString());
        emit(AdminLoadingError(error: e.toString()));
      }
    });
  }
}
