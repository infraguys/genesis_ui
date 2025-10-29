import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';
import 'package:genesis/src/features/roles/domain/params/create_role_binding_params.dart';
import 'package:genesis/src/features/roles/domain/params/get_role_bindings_params.dart';

abstract interface class IRoleBindingsRepository {
  Future<void> createRoleBinding(CreateRoleBindingParams params);

  Future<void> deleteRoleBinding(RoleBindingUUID uuid);

  Future<List<RoleBinding>> getRoleBindings(GetRoleBindingsParams params);
}
