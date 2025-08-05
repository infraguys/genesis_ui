part of 'role_editor_bloc.dart';

sealed class RoleEditorEvent {
  factory RoleEditorEvent.create({
    required String name,
    required List<Permission> permissions,
    String? description,
  }) = _CreateRole;
}

final class _CreateRole implements RoleEditorEvent {
  const _CreateRole({
    required this.name,
    required this.permissions,
    this.description,
  });

  final String name;
  final String? description;
  final List<Permission> permissions;
}
