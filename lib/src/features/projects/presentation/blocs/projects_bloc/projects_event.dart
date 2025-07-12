part of 'projects_bloc.dart';

sealed class ProjectsEvent {
  factory ProjectsEvent.getProjects() => _GetProjectsEvent();
}

final class _GetProjectsEvent implements ProjectsEvent {}
