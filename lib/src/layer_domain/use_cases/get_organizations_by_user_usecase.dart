import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class GetOrganizationsByUserUseCase {
  GetOrganizationsByUserUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<List<Organization>> call(String userUuid) async {
    return await _repository.getOrganizationByUser(userUuid);
  }
}
