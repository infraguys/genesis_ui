import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

final class GetRoleBindingsParams {
  GetRoleBindingsParams({
    this.userUUID,
    this.projectUUID,
    this.roleUUID,
    this.createdAt,
    this.updatedAt,
  });

  final UserUUID? userUUID;
  final ProjectUUID? projectUUID;
  final RoleUUID? roleUUID;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
