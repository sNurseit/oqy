part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable{}

class LoadAdminEvent extends AdminEvent{
  final Profile profile;
  LoadAdminEvent({required this.profile});
  @override
  List<Object?> get props => [profile];
}