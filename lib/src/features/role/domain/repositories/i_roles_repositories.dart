import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/role/domain/params/create_role_params.dart';

abstract interface class IRolesRepository {
  Future<List<Role>> getRolesByUserUuid(String userUuid);

  Future<Role?> createRole(CreateRoleParams params);
}
