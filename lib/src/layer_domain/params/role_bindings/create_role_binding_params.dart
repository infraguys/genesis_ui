import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

final class CreateRoleBindingParams {
  CreateRoleBindingParams({
    required this.userUUID,
    required this.roleUUID,
    this.projectUUID,
  });

  final String userUUID;
  final RoleUUID roleUUID;
  final ProjectUUID? projectUUID;
}
