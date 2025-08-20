part of 'projects_bloc.dart';

sealed class ProjectsEvent {
  factory ProjectsEvent.getProjects([GetProjectsParams? params]) = _GetProjects;
}

final class _GetProjects implements ProjectsEvent {
  const _GetProjects([GetProjectsParams? params]) : params = params ?? const GetProjectsParams();

  final GetProjectsParams params;
}
