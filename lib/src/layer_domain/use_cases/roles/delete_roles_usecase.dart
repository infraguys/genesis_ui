import 'package:genesis/src/layer_domain/params/roles/delete_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class DeleteRolesUseCase {
  DeleteRolesUseCase(this._repository);

  final IRolesRepository _repository;

  Future<List<void>> call(List<DeleteRoleParams> listOfParams) async {
    return await Future.wait(
      listOfParams.map((params) => _repository.deleteRole(params)),
    );
  }
}
