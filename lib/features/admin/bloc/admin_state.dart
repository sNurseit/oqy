part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {}

final class AdminInitial extends AdminState {
  @override
  List<Object?> get props => [];
}


final class AdminLoaded extends AdminState {
  final List<UserChangeDto> users;
  AdminLoaded({required this.users});
  @override
  List<Object?> get props => [users];
}

final class AdminLoading extends AdminState {
  @override
  List<Object?> get props => [];
}

final class AdminLoadingError extends AdminState {
  final String error;
  AdminLoadingError({required this.error});
  @override
  List<Object?> get props => [error];
}

