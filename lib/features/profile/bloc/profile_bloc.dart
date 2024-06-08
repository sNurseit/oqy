import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/auth_response.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/domain/provider/session_provider.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Profile? profile;
  AuthResponse? session;
  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      try{

        if (state is !ProfileLoaded) {
          emit(ProfileLoading());
        }
        profile = await profileService.getProfile();
        session = await getSession();
        emit(ProfileLoaded(profile: profile!, roles:session!.roles ));
      } catch (e){
        emit(ProfileLoadingFailure(exception: e));
      } finally{
        event.completer?.complete();
      }
    });

    on<GetProfile>((event,emit){
      emit(ProfileLoaded(profile: profile!, roles:session!.roles));
      event.completer?.complete();
    });

    on<NavigateToSettings>((event, emit) {
      AutoRouter.of(event.context).push( SettingsRoute(profile: profile));
    });
    
    //update profile 
    on<ChangeDataProfile>((event, emit) async {
      try{
        if (state is !ProfileUpdated) {
          emit(ProfileUpdating());
        }
        profile = await profileService.updateProfile(event.profile!);
        emit(ProfileUpdated(profile: profile!));
      } catch (e){
        emit(ProfileUpdateFailure(exception: e));
      } 
    });
   
    on<ChangeProfileAvatar>((event,emit) async{
      try{
        profile = await profileService.updateProfile(event.profile!);
      } catch (e){
        emit(ProfileUpdateFailure(exception: e));
      } 
    });
  }
  Future<AuthResponse> getSession() async {
    final authInfo = await SessionDataProvider().getSessions();
    return authInfo;
  }
  final ProfileService profileService;
}