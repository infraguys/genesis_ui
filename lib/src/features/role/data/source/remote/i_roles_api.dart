import 'package:genesis/src/features/role/data/dtos/role_dto.dart';

abstract interface class IRolesApi {
  Future<List<RoleDto>> getRolesByUserUuid(String userUuid);
}
