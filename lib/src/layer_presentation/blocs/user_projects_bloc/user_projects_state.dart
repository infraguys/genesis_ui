part of 'user_projects_bloc.dart';

sealed class UserProjectsState {
  factory UserProjectsState.initial() = UserProjectsInitState;

  factory UserProjectsState.loading() = UserProjectsLoadingState;

  factory UserProjectsState.loaded(List<Project> projects) = UserProjectsLoadedState;
}

final class UserProjectsInitState implements UserProjectsState {}

final class UserProjectsLoadingState implements UserProjectsState {}

final class UserProjectsLoadedState implements UserProjectsState {
  const UserProjectsLoadedState(this.projects);

  final List<Project> projects;
}
