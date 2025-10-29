import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permission_bindings_params.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';

final class GetPermissionBindingsUseCase {
  GetPermissionBindingsUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<List<PermissionBinding>> call(GetPermissionBindingsParams params) async {
    return await _repository.getPermissionBindings(params);
  }
}
