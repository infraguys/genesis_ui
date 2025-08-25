import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';

final class DeleteRoleBindingUseCase {
  DeleteRoleBindingUseCase(this._repository);

  final IRoleBindingsRepository _repository;

  Future<void> call(String uuid) async {
    return await _repository.deleteRoleBinding(uuid);
  }
}
