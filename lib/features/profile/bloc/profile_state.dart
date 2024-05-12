part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable{}

class ProfileInitial extends ProfileState{
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState{
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState{
  final Profile profile;

  ProfileLoaded({required this.profile});
  
  @override
  List<Object?> get props =>[profile];
}

class ProfileLoadingFailure extends ProfileState{
  final Object? exception;

  ProfileLoadingFailure({required this.exception});
  
  @override 
  List<Object?> get props => [exception];
}

//updating states
class ProfileUpdated extends ProfileState{
  final Profile profile;

  ProfileUpdated({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdating extends ProfileState{
  @override
  List<Object?> get props => [];
}

class ProfileUpdateFailure extends ProfileState{
  final Object? exception;

  ProfileUpdateFailure({required this.exception});
  
  @override 
  List<Object?> get props => [exception];
}