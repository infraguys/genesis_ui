import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/params/update_role_params.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';

final class UpdateRoleUseCase {
  UpdateRoleUseCase(this._rolesRepository);

  final IRolesRepository _rolesRepository;

  Future<Role> call(UpdateRoleParams params) async {
    return _rolesRepository.updateRole(params);
  }
}
