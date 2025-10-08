import 'package:genesis/src/layer_data/requests/permission_requests/get_permission_req.dart';
import 'package:genesis/src/layer_data/source/remote/permissions_api/permissions_api.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/params/get_permissions_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';

final class PermissionsRepository implements IPermissionsRepository {
  const PermissionsRepository(this._permissionsApi);

  final PermissionsApi _permissionsApi;

  @override
  Future<Permission> createPermission() {
    // TODO: implement createPermission
    throw UnimplementedError();
  }

  @override
  Future<Permission> getPermission() {
    // TODO: implement getPermission
    throw UnimplementedError();
  }

  @override
  Future<List<Permission>> getPermissions(GetPermissionsParams params) async {
    final req = GetPermissionsReq(params);
    final dtoList = await _permissionsApi.getPermissions(req);
    return dtoList.map((dto) => dto.toEntity()).toList();
  }
}
