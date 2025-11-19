part of 'permissions_bloc.dart';

sealed class PermissionsState {}

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
    String? query,
  }) {
    return PermissionsLoadedState(
      permissions: _permissions,
      query: query ?? this.query,
    );
  }
}
