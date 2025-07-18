part of 'auth_user_projects_bloc.dart';

sealed class AuthUserProjectsEvent {
  factory AuthUserProjectsEvent.getProjects(String userUuid) = _GetProjectsEvent;
}

final class _GetProjectsEvent implements AuthUserProjectsEvent {
  _GetProjectsEvent(this.userUuid);

  final String userUuid;
}
