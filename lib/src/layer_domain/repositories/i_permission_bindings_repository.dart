import 'package:genesis/src/layer_domain/entities/permission_binding.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/create_permission_binding_params.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/get_permission_bindings_params.dart';

abstract interface class IPermissionBindingsRepository {
  Future<PermissionBinding> createPermissionBinding(CreatePermissionBindingParams params);

  Future<List<PermissionBinding>> getPermissionBindings(GetPermissionBindingsParams params);

  Future<void> deletePermissionBinding(PermissionBindingUUID uuid);
}
