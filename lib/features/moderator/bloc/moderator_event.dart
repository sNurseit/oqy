part of 'moderator_bloc.dart';

abstract class ModeratorEvent extends Equatable{}

class LoadModerator extends ModeratorEvent{
  final int courseId;
  final Completer? completer;

  LoadModerator({required this.courseId, this.completer});
  @override
  List<Object?> get props => [courseId, completer];
}