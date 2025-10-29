import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';

final class DeleteRoleBindingUseCase {
  DeleteRoleBindingUseCase(this._repository);

  final IRoleBindingsRepository _repository;

  Future<void> call(RoleBinding binding) async {
    await _repository.deleteRoleBinding(binding.uuid);
  }
}

final class DeleteRoleBindingsUseCase {
  DeleteRoleBindingsUseCase(this._repository);

  final IRoleBindingsRepository _repository;

  Future<void> call(List<RoleBinding> bindings) async {
    if (bindings.isNotEmpty) {
      final uuids = bindings.map((it) => it.uuid).toList();
      await Future.wait(uuids.map(_repository.deleteRoleBinding));
    }
  }
}
