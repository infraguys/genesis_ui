import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';
import 'package:genesis/src/features/roles/domain/params/get_role_bindings_params.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';

// final class GetRoleBindingUseCase {
//   GetRoleBindingUseCase(this._repository);

//   final IRoleBindingsRepository _repository;

//   Future<List<RoleBinding>> call(GetRoleBindingsParams params) async {
//     throw UnimplementedError();
//   }
// }

final class GetRoleBindingsUseCase {
  GetRoleBindingsUseCase(this._repository);

  final IRoleBindingsRepository _repository;

  Future<List<RoleBinding>> call(GetRoleBindingsParams params) async {
    return await _repository.getRoleBindings(params);
  }
}
