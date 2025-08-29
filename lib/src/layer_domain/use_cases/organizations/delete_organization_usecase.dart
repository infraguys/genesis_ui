import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class DeleteOrganizationUseCase {
  DeleteOrganizationUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<void> call(OrganizationUUID params) async {
    await _repository.deleteOrganization(params);
  }
}
