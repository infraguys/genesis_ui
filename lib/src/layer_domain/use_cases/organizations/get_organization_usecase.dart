import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class GetOrganizationUseCase {
  GetOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<Organization> call(OrganizationUUID uuid) async {
    return await _repository.getOrganization(uuid);
  }
}
