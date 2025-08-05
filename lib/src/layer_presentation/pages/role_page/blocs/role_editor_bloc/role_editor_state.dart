part of 'role_editor_bloc.dart';

sealed class RoleEditorState {
  factory RoleEditorState.initial() = RoleEditorInitialState;

  factory RoleEditorState.loading() = RoleEditorLoadingState;

  factory RoleEditorState.success() = RoleEditorStateSuccess;
}

class RoleEditorInitialState implements RoleEditorState {}

class RoleEditorLoadingState implements RoleEditorState {}

final class RoleEditorStateSuccess implements RoleEditorState {}
