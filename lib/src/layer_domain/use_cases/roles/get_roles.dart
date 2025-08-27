import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/get_roles_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class GetRolesUseCase {
  GetRolesUseCase(this._repository);

  final IRolesRepository _repository;

  Future<List<Role>> call(GetRolesParams params) async {
    return _repository.getRoles(params);
  }
}
