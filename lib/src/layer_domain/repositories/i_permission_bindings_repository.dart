import 'package:genesis/src/layer_domain/entities/permission_binding.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/create_permission_binding_params.dart';

abstract interface class IPermissionBindingsRepository {
  Future<PermissionBinding> createPermissionBinding(CreatePermissionBindingParams params);

  Future<void> deletePermissionBinding(String uuid);
}
