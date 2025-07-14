import 'package:genesis/src/features/common/shared_entities/role.dart';

abstract interface class IRolesRepository {
  Future<List<Role>> getUserRoles();
}
