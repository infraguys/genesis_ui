part of 'organization_editor_bloc.dart';

sealed class OrganizationEditorState {
  factory OrganizationEditorState.initial() = OrganizationEditorInitial;

  factory OrganizationEditorState.loading() = OrganizationEditorLoading;

  factory OrganizationEditorState.success() = OrganizationEditorStateSuccess;
}

final class OrganizationEditorInitial implements OrganizationEditorState {}

final class OrganizationEditorLoading implements OrganizationEditorState {}

final class OrganizationEditorStateSuccess implements OrganizationEditorState {}
