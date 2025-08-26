part of 'role_bindings_bloc.dart';

sealed class RoleBindingsEvent {
  factory RoleBindingsEvent.delete({
    required final String userUuid,
    required final String roleUuid,
    required final String projectUuid,
  }) = _Delete;

  factory RoleBindingsEvent.get(GetRoleBindingsParams params) = _GetBinding;
}

final class _Delete implements RoleBindingsEvent {
  const _Delete({required this.userUuid, required this.roleUuid, required this.projectUuid});

  final String userUuid;
  final String roleUuid;
  final String projectUuid;
}

final class _GetBinding implements RoleBindingsEvent {
  const _GetBinding(this.params);

  final GetRoleBindingsParams params;
}
