import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class DeleteRolesUseCase {
  DeleteRolesUseCase(this._repository);

  final IRolesRepository _repository;

  Future<List<void>> call(List<String> uuids) async {
    return await Future.wait(uuids.map(_repository.deleteRole));
  }
}
