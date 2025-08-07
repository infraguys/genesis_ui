import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/create_role_params.dart';

abstract interface class IRolesRepository {
  Future<List<Role>> getRolesByUserUuid(String userUuid);

  Future<Role> createRole(CreateRoleParams params);
}
