part of 'permissions_bloc.dart';

sealed class PermissionsState {
  factory PermissionsState.initial() = PermissionsInitialState;

  factory PermissionsState.loading() = PermissionsLoadingState;

  factory PermissionsState.loaded({required List<Permission> permissions, String query}) = PermissionsLoadedState;
}

final class PermissionsInitialState implements PermissionsState {}

final class PermissionsLoadingState implements PermissionsState {}

final class PermissionsLoadedState implements PermissionsState {
  PermissionsLoadedState({required List<Permission> permissions, this.query = ''}) : _permissions = permissions;

  final List<Permission> _permissions;
  final String query;

  List<Permission> get permissions {
    if (query.isEmpty) {
      return _permissions;
    }
    final q = query.toLowerCase();
    final filtered = _permissions.where((permission) => permission.name.toLowerCase().contains(q));
    return filtered.toList();
  }

  PermissionsLoadedState copyWith({
    List<Permission>? permissions,
    String? query,
  }) {
    return PermissionsLoadedState(
      permissions: permissions ?? this.permissions,
      query: query ?? this.query,
    );
  }
}
