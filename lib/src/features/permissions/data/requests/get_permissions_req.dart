import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/permissions_endpoints.dart';
import 'package:genesis/src/features/permissions/data/json_converters/permission_status_converter.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permissions_params.dart';

final class GetPermissionsReq extends IRequest {
  const GetPermissionsReq(this._params);

  final GetPermissionsParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?PermissionStatusConverter().toJson(_params.status),
    };
  }

  @override
  String get path {
    return PermissionsEndpoints.items().fullPath;
  }
}
