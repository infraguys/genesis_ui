part of 'user_projects_bloc.dart';

sealed class UserProjectsEvent {
  factory UserProjectsEvent.getProjects([GetProjectsParams? params]) = _GetProjects;
}

final class _GetProjects implements UserProjectsEvent {
  const _GetProjects([GetProjectsParams? params]) : params = params ?? const GetProjectsParams();

  final GetProjectsParams params;
}
