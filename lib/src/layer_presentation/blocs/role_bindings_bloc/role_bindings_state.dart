part of 'role_bindings_bloc.dart';

sealed class RoleBindingsState {
  factory RoleBindingsState.initial() = RoleBindingsInitialState;

  factory RoleBindingsState.loading() = RoleBindingsLoadingState;

  factory RoleBindingsState.loaded() = RoleBindingsLoadedState;

  factory RoleBindingsState.created() = RoleBindingsCreatedState;

  factory RoleBindingsState.deleted() = RoleBindingsDeletedState;
}

final class RoleBindingsInitialState implements RoleBindingsState {}

final class RoleBindingsLoadingState implements RoleBindingsState {}

final class RoleBindingsLoadedState implements RoleBindingsState {}

final class RoleBindingsCreatedState implements RoleBindingsState {}

final class RoleBindingsDeletedState implements RoleBindingsState {}

final class RoleBindingsFailureState implements RoleBindingsState {
  RoleBindingsFailureState(this.message);

  final String message;
}
