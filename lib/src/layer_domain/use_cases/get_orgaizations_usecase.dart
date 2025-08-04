import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/get_organizations_params.dart';

final class GetOrganizationsUseCase {
  GetOrganizationsUseCase(this._repository);

  final IOrganizationsRepository _repository;

  Future<List<Organization>> call(GetOrganizationsParams params) async {
    return await _repository.getOrganizations(params);
  }
}
