import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/role/data/source/remote/i_roles_api.dart';
import 'package:genesis/src/features/role/domain/repositories/i_roles_repositories.dart';

final class RolesRepository implements IRolesRepository {
  RolesRepository(this._rolesApi);

  final IRolesApi _rolesApi;

  @override
  Future<List<Role>> getRolesByUserUuid(String userUuid) async {
    final rolesDto = await _rolesApi.getRolesByUserUuid(userUuid);
    return rolesDto.map((dto) => dto.toEntity()).toList();
  }
}
