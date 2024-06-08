part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable{}

class LoadProfile extends ProfileEvent{
  final Completer? completer;
  LoadProfile({this.completer});
  
  @override
  List<Object?> get props => [completer];
}

class GetProfile extends ProfileEvent{
  final Completer? completer;
  GetProfile({this.completer});
  
  @override
  List<Object?> get props => [completer];
}


class FetchProfile extends ProfileEvent{
  final BuildContext context;
  final String type;
  FetchProfile({required this.context, required this.type});
  @override
  List<Object?> get props => [];
}

class ChangeDataProfile extends ProfileEvent{
  final Profile? profile;
  ChangeDataProfile({ required this.profile});
  @override
  List<Object?> get props => [profile];
}

class ChangeProfileAvatar extends ProfileEvent{
  final Profile? profile;
  ChangeProfileAvatar({ required this.profile});
  @override
  List<Object?> get props => [profile];
}


class NavigateToSettings extends ProfileEvent{
  final BuildContext context;
  NavigateToSettings({required this.context});
  @override
  List<Object?> get props => [context];
}