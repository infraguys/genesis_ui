import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/update_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class UpdateOrganizationUseCase {
  UpdateOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<Organization> call(UpdateOrganizationParams params) async {
    return await _repository.updateOrganization(params);
  }
}
