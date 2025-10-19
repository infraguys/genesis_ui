import 'package:genesis/src/core/network/endpoints/permissions_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permissions_params.dart';

final class GetPermissionsReq {
  GetPermissionsReq(this._params);

  final GetPermissionsParams _params;

  Map<String, dynamic> toQuery() {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?_fromStatus(_params.status),
    };
  }

  String? _fromStatus(PermissionStatus? status) => switch (status) {
    PermissionStatus.active => 'ACTIVE',
    _ => null,
  };

  String toPath() => PermissionsEndpoints.getPermissions();
}
