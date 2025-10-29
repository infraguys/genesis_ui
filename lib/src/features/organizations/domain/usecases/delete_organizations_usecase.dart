import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class DeleteOrganizationsUseCase {
  DeleteOrganizationsUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<void> call(List<Organization> organizations) async {
    final uuids = organizations.map((it) => it.id).toList();
    await Future.wait(uuids.map(_repository.deleteOrganization));
  }
}
