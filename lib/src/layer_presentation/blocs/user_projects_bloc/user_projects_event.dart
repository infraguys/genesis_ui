part of 'user_projects_bloc.dart';

sealed class UserProjectsEvent {
  factory UserProjectsEvent.getProjects(String userUuid, {GetProjectsParams params}) = _GetProjects;
}

final class _GetProjects implements UserProjectsEvent {
  const _GetProjects(
    this.userUuid, {
    this.params = const GetProjectsParams(),
  });

  final GetProjectsParams params;
  final String userUuid;
}
