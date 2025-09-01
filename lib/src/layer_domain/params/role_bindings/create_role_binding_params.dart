import 'package:genesis/src/layer_domain/entities/project.dart';

final class CreateRoleBindingParams {
  CreateRoleBindingParams({
    required this.userUUID,
    required this.roleUUID,
    this.projectUUID,
  });

  final String userUUID;
  final String roleUUID;
  final ProjectUUID? projectUUID;
}
