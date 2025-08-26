import 'package:genesis/src/layer_data/requests/permission_bindings/create_permission_binding_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_permission_bindings_api.dart';
import 'package:genesis/src/layer_domain/entities/permission_binding.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';

final class PermissionBindingsRepository implements IPermissionBindingsRepository {
  PermissionBindingsRepository(this._permissionBindingsApi);

  final IPermissionBindingsApi _permissionBindingsApi;

  @override
  Future<PermissionBinding> createPermissionBinding(params) async {
    final dto = await _permissionBindingsApi.createPermissionBinding(CreatePermissionBindingReq(params));
    return dto.toEntity();
  }

  @override
  Future<void> deletePermissionBinding(uuid) async {
    throw UnimplementedError();
  }
}
