import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class CreateRoleBindingParams {
  CreateRoleBindingParams({
    required this.userUUID,
    required this.roleUUID,
    this.projectUUID,
  });

  final UserUUID userUUID;
  final RoleUUID roleUUID;
  final ProjectID? projectUUID;
}
