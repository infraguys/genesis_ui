import 'package:genesis/src/features/role/data/dto/role_dto.dart';

abstract interface class IRolesApi {
  Future<RoleDto> getRoleByUserUuid(String uuid);
}
