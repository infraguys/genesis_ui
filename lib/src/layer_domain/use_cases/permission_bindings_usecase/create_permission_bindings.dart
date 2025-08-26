import 'package:genesis/src/layer_domain/params/permission_bindings_params/create_permission_binding_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';

final class CreatePermissionBindingUseCase {
  CreatePermissionBindingUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call(CreatePermissionBindingParams params) async {
    await _repository.createPermissionBinding(params);
  }
}

final class CreatePermissionBindingsUseCase {
  CreatePermissionBindingsUseCase(this._repository);

  final IPermissionBindingsRepository _repository;

  Future<void> call(List<CreatePermissionBindingParams> listOfParams) async {
    await Future.wait(
      listOfParams.map((params) => _repository.createPermissionBinding(params)),
    );
  }
}
