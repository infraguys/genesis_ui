import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class CreateOrganizationUseCase {
  CreateOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<Organization> call(CreateOrganizationParams params) async {
    return await _repository.createOrganization(params);
  }
}
