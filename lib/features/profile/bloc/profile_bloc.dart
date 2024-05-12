import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  Profile? profile;

  ProfileBloc(this.profileService) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      try{
        if (state is !ProfileLoaded) {
          emit(ProfileLoading());
        }
        profile = await profileService.getProfile();
        emit(ProfileLoaded(profile: profile!));
      } catch (e){
        emit(ProfileLoadingFailure(exception: e));
      } finally{
        event.completer?.complete();
      }
    });

    on<NavigateToSettings>((event, emit) {
      AutoRouter.of(event.context!).replace( SettingsRoute(profile: profile!));
    });
    
    //update profile 
    on<ChangeDataProfile>((event, emit) async {
      try{
        if (state is !ProfileUpdated) {
          emit(ProfileUpdating());
        }
        final profile = await profileService.updateProfile(event.profile!);
        emit(ProfileUpdated(profile: profile));
      } catch (e){
        emit(ProfileUpdateFailure(exception: e));
      } 
    });
   
  }

  final ProfileService profileService;
}