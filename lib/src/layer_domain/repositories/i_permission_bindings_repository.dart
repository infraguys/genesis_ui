import 'package:genesis/src/layer_domain/params/permission_bindings_params/create_permission_binding_params.dart';

abstract interface class IPermissionBindingsRepository {
  Future<void> createPermissionBinding(CreatePermissionBindingParams params);

  Future<void> deletePermissionBinding(String uuid);
}
