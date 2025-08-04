part of 'role_editor_bloc.dart';

sealed class RoleEditorEvent {
  factory RoleEditorEvent.create({
    required String name,
    required Permission permission,
    String? description,
  }) = _CreateRole;
}

final class _CreateRole implements RoleEditorEvent {
  const _CreateRole({
    required this.name,
    required this.permission,
    this.description,
  });

  final String name;
  final String? description;
  final Permission permission;
}
