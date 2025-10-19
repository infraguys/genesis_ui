import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';

final class GetOrganizationsReq {
  GetOrganizationsReq(this._params);

  final GetOrganizationsParams _params;

  Map<String, dynamic> toQuery() {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?_fromStatus(_params.status),
    };
  }

  String? _fromStatus(OrganizationStatus? status) => switch (status) {
    OrganizationStatus.active => 'ACTIVE',
    _ => null,
  };

  String toPath() => OrganizationsEndpoints.getOrganizations();
}
