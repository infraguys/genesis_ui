part of 'user_projects_bloc.dart';

sealed class UserProjectsEvent {
  factory UserProjectsEvent.getProjects(String userUuid) = _GetProjects;
}

final class _GetProjects implements UserProjectsEvent {
  const _GetProjects(this.userUuid);

  final String userUuid;
}
