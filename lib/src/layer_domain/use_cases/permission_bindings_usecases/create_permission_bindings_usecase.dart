import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/create_permission_binding_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';

final class CreatePermissionBindingUseCase {
  CreatePermissionBindingUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call(CreatePermissionBindingParams params) async {
    await _repository.createPermissionBinding(params);
  }
}

final class CreatePermissionBindingsUseCase {
  CreatePermissionBindingsUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call({required List<Permission> permissions, required RoleUUID roleUUID}) async {
    if (permissions.isNotEmpty) {
      await Future.wait(
        permissions.map(
          (permission) => _repository.createPermissionBinding(
            CreatePermissionBindingParams(permissionUUID: permission.uuid, roleUUID: roleUUID),
          ),
        ),
      );
    }
  }
}
