import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/data/json_converters/organization_status_converter.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';

final class GetOrganizationsReq extends IRequest {
  GetOrganizationsReq(this._params);

  final GetOrganizationsParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?OrganizationStatusConverter().toJson(_params.status),
    };
  }

  @override
  String get path {
    return OrganizationsEndpoints.items().fullPath;
  }


}
