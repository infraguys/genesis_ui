import 'package:genesis/src/features/common/shared_entities/permission.dart';
import 'package:genesis/src/features/permissions/domain/i_permissions_repository.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permissions_params.dart';

final class GetPermissionsUseCases {
  GetPermissionsUseCases(this._repository);

  final IPermissionsRepository _repository;

  Future<List<Permission>> call(GetPermissionsParams params) async {
    return await _repository.getPermissions(params);
  }
}
