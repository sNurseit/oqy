part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable{}

class LoadProfile extends ProfileEvent{
  final Completer? completer;
  LoadProfile({this.completer});
  
  @override
  List<Object?> get props => [completer];
}

class ChangeDataProfile extends ProfileEvent{
  final Profile? profile;
  ChangeDataProfile({ required this.profile});
  @override
  List<Object?> get props => [profile];
}

class NavigateToSettings extends ProfileEvent{
  final Profile? profile;
  final BuildContext? context;
  NavigateToSettings({ required this.profile, required this.context});
  @override
  List<Object?> get props => [];
}