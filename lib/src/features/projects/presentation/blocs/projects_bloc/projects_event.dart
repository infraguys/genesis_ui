part of 'projects_bloc.dart';

sealed class ProjectsEvent {
  factory ProjectsEvent.getProjects(String userUuid) = _GetProjectsEvent;
}

final class _GetProjectsEvent implements ProjectsEvent {
  const _GetProjectsEvent(this.userUuid);

  final String userUuid;
}
