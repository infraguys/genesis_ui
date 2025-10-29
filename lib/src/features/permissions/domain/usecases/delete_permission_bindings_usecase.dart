import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';

final class DeletePermissionBindingUseCase {
  DeletePermissionBindingUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call(PermissionBindingID uuid) async {
    return await _repository.deletePermissionBinding(uuid);
  }
}

final class DeletePermissionBindingsUseCase {
  DeletePermissionBindingsUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call(List<PermissionBinding> bindings) async {
    if (bindings.isNotEmpty) {
      final uuids = bindings.map((it) => it.id).toList();
      await Future.wait(uuids.map(_repository.deletePermissionBinding));
    }
  }
}
