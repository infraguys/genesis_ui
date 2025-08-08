import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/organizations/edit_organiztion_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class EditOrganizationUseCase {
  EditOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<Organization> call(EditOrganizationParams params) async {
    return await _repository.editOrganization(params);
  }
}
