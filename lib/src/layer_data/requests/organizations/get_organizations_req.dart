import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_domain/params/organizations/get_organizations_params.dart';

final class GetOrganizationsReq implements QueryEncodable, PathEncodable {
  GetOrganizationsReq(this._params);

  final GetOrganizationsParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?_fromStatus(_params.status),
    };
  }

  String? _fromStatus(Status? status) {
    return switch (status) {
      Status.active => 'ACTIVE',
      _ => null,
    };
  }

  @override
  String toPath() {
    return OrganizationsEndpoints.getOrganizations;
  }
}
