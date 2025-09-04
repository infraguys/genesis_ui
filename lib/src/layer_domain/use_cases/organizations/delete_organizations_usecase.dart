import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class DeleteOrganizationsUseCase {
  DeleteOrganizationsUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<void> call(List<Organization> organizations) async {
    final uuids = organizations.map((it) => it.uuid).toList();
    await Future.wait(uuids.map(_repository.deleteOrganization));
  }
}
