import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';

final class CreateOrganizationReq extends IRequest {
  CreateOrganizationReq(this._params);

  final CreateOrganizationParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  @override
  String get path {
    return OrganizationsEndpoints.items().fullPath;
  }
}
