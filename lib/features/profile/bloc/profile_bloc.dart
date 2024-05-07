import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/service/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      try{
        emit(ProfileLoading());
        final profile = await profileService.getProfile();
        emit(ProfileLoaded(profile: profile));
      } catch (e){
        emit(ProfileLoadingFailure(exception: e));
      }
    });
  }

  final ProfileService profileService;
}