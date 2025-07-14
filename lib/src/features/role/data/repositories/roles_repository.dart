import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/role/domain/repositories/i_roles_repositories.dart';

final class RolesRepository implements IRolesRepository {
  @override
  Future<List<Role>> getRolesByUserUuid(String userUuid) {
    // TODO: implement getUserRoles
    throw UnimplementedError();
  }
}
