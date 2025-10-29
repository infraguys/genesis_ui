import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class GetOrganizationsUseCase {
  GetOrganizationsUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<List<Organization>> call(GetOrganizationsParams params) async {
    return await _repository.getOrganizations(params);
  }
}
