import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';

final class GetRoleUseCase {
  GetRoleUseCase(this._repository);

  final IRolesRepository _repository;

  Future<Role> call(RoleUUID uuid) async {
    return _repository.getRole(uuid);
  }
}
