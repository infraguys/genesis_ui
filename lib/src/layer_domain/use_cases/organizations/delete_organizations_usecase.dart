import 'package:genesis/src/layer_domain/params/organizations/delete_organization_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class DeleteOrganizationsUseCase {
  DeleteOrganizationsUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<void> call(List<DeleteOrganizationParams> listOfParams) async {
    await Future.wait(
      listOfParams.map((params) => _repository.deleteOrganization(params)),
    );
  }
}
