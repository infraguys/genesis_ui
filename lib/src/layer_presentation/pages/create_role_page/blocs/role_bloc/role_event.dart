part of 'role_bloc.dart';

sealed class RoleEvent {
  factory RoleEvent.create({
    required String name,
    required List<Permission> permissions,
    String? description,
  }) = _CreateRole;
}

final class _CreateRole implements RoleEvent {
  const _CreateRole({
    required this.name,
    required this.permissions,
    this.description,
  });

  final String name;
  final String? description;
  final List<Permission> permissions;
}
