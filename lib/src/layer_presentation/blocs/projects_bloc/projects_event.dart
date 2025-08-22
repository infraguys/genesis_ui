part of 'projects_bloc.dart';

sealed class ProjectsEvent {
  factory ProjectsEvent.getProjects([GetProjectsParams? params]) = _Get;

  factory ProjectsEvent.deleteProjects(List<DeleteProjectParams> listOfParams) = _DeleteProjects;
}

final class _Get implements ProjectsEvent {
  const _Get([GetProjectsParams? params]) : params = params ?? const GetProjectsParams();

  final GetProjectsParams params;
}

final class _DeleteProjects implements ProjectsEvent {
  const _DeleteProjects(this.listOfParams);

  final List<DeleteProjectParams> listOfParams;
}
