import 'package:genesis/src/layer_domain/entities/role_binding.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/get_role_bindings_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';

final class GetRoleBindingsUseCase {
  GetRoleBindingsUseCase(this._repository);

  final IRoleBindingsRepository _repository;

  Future<List<RoleBinding>> call(GetRoleBindingsParams params) async {
    return await _repository.getRoleBindings(params);
  }
}
