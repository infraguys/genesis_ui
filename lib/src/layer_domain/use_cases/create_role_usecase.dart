import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/create_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class CreateRoleUseCase {
  const CreateRoleUseCase(this._repository);

  final IRolesRepository _repository;

  Future<Role?> call(CreateRoleParams params) async {
    return await _repository.createRole(params);
  }
}
