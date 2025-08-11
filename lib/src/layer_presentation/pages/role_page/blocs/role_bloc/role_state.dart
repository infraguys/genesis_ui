part of 'role_bloc.dart';

sealed class RoleState {
  factory RoleState.initial() = RoleEditorInitialState;

  factory RoleState.loading() = RoleEditorLoadingState;

  factory RoleState.success() = RoleEditorStateSuccess;
}

class RoleEditorInitialState implements RoleState {}

class RoleEditorLoadingState implements RoleState {}

final class RoleEditorStateSuccess implements RoleState {}
