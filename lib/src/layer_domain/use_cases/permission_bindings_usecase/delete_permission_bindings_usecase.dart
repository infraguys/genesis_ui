import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';

final class DeletePermissionBindingUseCase {
  DeletePermissionBindingUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call(String uuid) async {
    return await _repository.deletePermissionBinding(uuid);
  }
}

final class DeletePermissionBindingsUseCase {
  DeletePermissionBindingsUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call(List<String> uuids) async {
    await Future.wait(uuids.map(_repository.deletePermissionBinding));
  }
}
