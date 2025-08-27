import 'package:genesis/src/layer_domain/entities/role_binding.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';

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
