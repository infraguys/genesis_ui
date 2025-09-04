import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class DeleteRoleUseCase {
  DeleteRoleUseCase(this._repository);

  final IRolesRepository _repository;

  Future<void> call(RoleUUID uuid) async {
    await _repository.deleteRole(uuid);
  }
}

final class DeleteRolesUseCase {
  DeleteRolesUseCase(this._repository);

  final IRolesRepository _repository;

  Future<List<void>> call(List<Role> roles) async {
    final uuids = roles.map((role) => role.uuid).toList();
    return await Future.wait(uuids.map(_repository.deleteRole));
  }
}
