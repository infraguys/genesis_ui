import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class GetOrganizationUseCase {
  GetOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<Organization> call(OrganizationID id) async {
    return await _repository.getOrganization(id);
  }
}
