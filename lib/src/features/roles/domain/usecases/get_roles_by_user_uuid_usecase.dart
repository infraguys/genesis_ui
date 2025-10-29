import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';

final class GetRolesByUserUuidUseCase {
  GetRolesByUserUuidUseCase(this._rolesRepository);

  final IRolesRepository _rolesRepository;

  Future<List<Role>> call(String userUuid) async {
    return _rolesRepository.getRolesByUserUuid(userUuid);
  }
}
