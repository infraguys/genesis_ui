import 'package:genesis/src/layer_data/dtos/role_dto.dart';
import 'package:genesis/src/layer_data/requests/create_role_req.dart';

abstract interface class IRolesApi {
  Future<List<RoleDto>> getRolesByUserUuid(String userUuid);

  Future<RoleDto?> createRole(CreateRoleReq req);
}
