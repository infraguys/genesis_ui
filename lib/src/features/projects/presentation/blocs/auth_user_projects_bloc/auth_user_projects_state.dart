part of 'auth_user_projects_bloc.dart';

sealed class AuthUserProjectsState {
  factory AuthUserProjectsState.initial() = AuthUserProjectsInitState;

  factory AuthUserProjectsState.loading() = AuthUserProjectsLoadingState;

  factory AuthUserProjectsState.loaded(List<Project> projects) = AuthUserProjectsLoadedState;
}

final class AuthUserProjectsInitState implements AuthUserProjectsState {}

final class AuthUserProjectsLoadingState implements AuthUserProjectsState {}

final class AuthUserProjectsLoadedState implements AuthUserProjectsState {
  AuthUserProjectsLoadedState(this.projects);

  final List<Project> projects;
}
