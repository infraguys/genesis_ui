import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';

final class GetRoleBindingsParams {
  GetRoleBindingsParams({
    this.userUUID,
    this.projectUUID,
    this.roleUUID,
    this.createdAt,
    this.updatedAt,
  });

  final UserID? userUUID;
  final ProjectID? projectUUID;
  final RoleUUID? roleUUID;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
