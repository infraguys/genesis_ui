import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class CreateRoleBindingParams {
  CreateRoleBindingParams({
    required this.userID,
    required this.roleID,
    this.projectID,
  });

  final UserID userID;
  final RoleID roleID;
  final ProjectID? projectID;
}
