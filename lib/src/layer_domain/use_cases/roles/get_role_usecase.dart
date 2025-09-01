import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class GetRoleUseCase {
  GetRoleUseCase(this._repository);

  final IRolesRepository _repository;

  Future<Role> call(RoleUUID uuid) async {
    return _repository.getRole(uuid);
  }
}
