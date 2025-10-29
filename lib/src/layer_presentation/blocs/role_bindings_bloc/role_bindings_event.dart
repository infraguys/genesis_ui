part of 'role_bindings_bloc.dart';

sealed class RoleBindingsEvent {
  factory RoleBindingsEvent.delete({
    required final UserID userUUID,
    required final RoleUUID roleUUID,
    required final ProjectID projectUUID,
  }) = _Delete;

  factory RoleBindingsEvent.get(GetRoleBindingsParams params) = _GetBinding;

  factory RoleBindingsEvent.createBindings(List<CreateRoleBindingParams> params) = _CreateBindings;
}

final class _Delete implements RoleBindingsEvent {
  const _Delete({required this.userUUID, required this.roleUUID, required this.projectUUID});

  final UserID userUUID;
  final RoleUUID roleUUID;
  final ProjectID projectUUID;
}

final class _GetBinding implements RoleBindingsEvent {
  const _GetBinding(this.params);

  final GetRoleBindingsParams params;
}

final class _CreateBindings implements RoleBindingsEvent {
  const _CreateBindings(this.listOfParams);

  final List<CreateRoleBindingParams> listOfParams;
}
