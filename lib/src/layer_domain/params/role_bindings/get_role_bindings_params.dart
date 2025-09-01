import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

final class GetRoleBindingsParams {
  GetRoleBindingsParams({
    this.userUuid,
    this.projectUUID,
    this.roleUUID,
    this.createdAt,
    this.updatedAt,
  });

  final String? userUuid;
  final ProjectUUID? projectUUID;
  final RoleUUID? roleUUID;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
