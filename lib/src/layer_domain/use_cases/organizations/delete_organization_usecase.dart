import 'package:genesis/src/layer_domain/params/organizations/delete_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class DeleteOrganizationUseCase {
  DeleteOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<void> call(DeleteOrganizationParams params) async {
    await _repository.deleteOrganization(params);
  }
}
