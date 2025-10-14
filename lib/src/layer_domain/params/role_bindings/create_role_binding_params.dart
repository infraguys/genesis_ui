import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

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
