part of 'profile_bloc.dart';

class ProfileState {}

class ProfileInitial extends ProfileState{}

class ProfileLoading extends ProfileState{}

class ProfileLoaded extends ProfileState{
  final Profile profile;

  ProfileLoaded({required this.profile});
}

class ProfileLoadingFailure extends ProfileState{
  final Object? exception;

  ProfileLoadingFailure({required this.exception});
}