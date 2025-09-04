part of 'permission_bindings_bloc.dart';

sealed class PermissionBindingsState {
  factory PermissionBindingsState.initial() = PermissionBindingsInitial;

  factory PermissionBindingsState.loading() = PermissionBindingsLoading;

  factory PermissionBindingsState.loaded(List<PermissionBinding> bindings) = PermissionBindingsLoaded;
}

final class PermissionBindingsInitial implements PermissionBindingsState {}

final class PermissionBindingsLoading implements PermissionBindingsState {}

final class PermissionBindingsLoaded implements PermissionBindingsState {
  PermissionBindingsLoaded(this.bindings);

  final List<PermissionBinding> bindings;
}
