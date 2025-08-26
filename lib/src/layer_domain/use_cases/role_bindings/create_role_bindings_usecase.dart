import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';

final class CreateRoleBindingsUseCase {
  CreateRoleBindingsUseCase(this._repository);

  final IRoleBindingsRepository _repository;

  Future<void> call(List<CreateRoleBindingParams> listOfParams) async {
    await Future.wait(
      listOfParams.map((params) => _repository.createRoleBinding(params)),
    );
  }
}
