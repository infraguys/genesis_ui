import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class DeleteOrganizationUseCase {
  DeleteOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<void> call(OrganizationID id) async {
    await _repository.deleteOrganization(id);
  }
}
