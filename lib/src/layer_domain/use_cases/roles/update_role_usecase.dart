import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/update_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class UpdateRoleUseCase {
  UpdateRoleUseCase(this._rolesRepository);

  final IRolesRepository _rolesRepository;

  Future<Role> call(UpdateRoleParams params) async {
    return _rolesRepository.updateRole(params);
  }
}
