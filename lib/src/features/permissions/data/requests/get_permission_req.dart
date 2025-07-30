import 'package:genesis/src/features/common/shared_entities/permission.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permissions_params.dart';

final class GetPermissionsReq {
  GetPermissionsReq(GetPermissionsParams params)
    : name = params.name,
      description = params.description,
      createdAt = params.createdAt?.toIso8601String(),
      updatedAt = params.updatedAt?.toIso8601String(),
      status = switch (params.status) {
        PermissionStatus.active => 'ACTIVE',
        _ => null,
      };

  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
}
