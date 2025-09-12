import 'package:genesis/src/layer_data/requests/permission_binding_requests/create_permission_binding_req.dart';
import 'package:genesis/src/layer_data/requests/permission_binding_requests/delete_permission_binding_req.dart';
import 'package:genesis/src/layer_data/requests/permission_binding_requests/get_permission_bindings_req.dart';
import 'package:genesis/src/layer_data/source/remote/permission_bindings_api/i_permission_bindings_api.dart';
import 'package:genesis/src/layer_domain/entities/permission_binding.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';

final class PermissionBindingsRepository implements IPermissionBindingsRepository {
  PermissionBindingsRepository(this._permissionBindingsApi);

  final IPermissionBindingsApi _permissionBindingsApi;

  @override
  Future<List<PermissionBinding>> getPermissionBindings(params) async {
    final dtos = await _permissionBindingsApi.getPermissionBindings(GetPermissionBindingsReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<PermissionBinding> createPermissionBinding(params) async {
    final dto = await _permissionBindingsApi.createPermissionBinding(CreatePermissionBindingReq(params));
    return dto.toEntity();
  }

  @override
  Future<void> deletePermissionBinding(uuid) async {
    await _permissionBindingsApi.deletePermissionBinding(DeletePermissionBindingReq(uuid));
  }
}
