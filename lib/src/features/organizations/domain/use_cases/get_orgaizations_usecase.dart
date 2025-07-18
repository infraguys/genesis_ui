import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class GetOrganizationsUseCase {
  GetOrganizationsUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<List<Organization>> call(String userUuid) async {
    return await _repository.getOrganizationByUser(userUuid);
  }
}
