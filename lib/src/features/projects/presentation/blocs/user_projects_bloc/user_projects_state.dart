part of 'user_projects_bloc.dart';

sealed class UserProjectsState {
  factory UserProjectsState.initial() = UserProjectsInitState;

  factory UserProjectsState.loading() = UserProjectsLoadingState;

  factory UserProjectsState.loaded(List<({Project project, List<Role> roles})> projectsWithRoles) =
      UserProjectsLoadedState;

  factory UserProjectsState.permissionFailure(String message) = UserProjectsPermissionFailureState;
}

final class UserProjectsInitState implements UserProjectsState {}

final class UserProjectsLoadingState implements UserProjectsState {}

final class UserProjectsPermissionFailureState implements UserProjectsState {
  UserProjectsPermissionFailureState(this.message);

  final String message;
}

final class UserProjectsLoadedState implements UserProjectsState {
  const UserProjectsLoadedState(this.projectsWithRoles);

  final List<({Project project, List<Role> roles})> projectsWithRoles;
}
