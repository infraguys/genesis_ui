import 'package:genesis/src/layer_domain/entities/project.dart';

final class GetRoleBindingsParams {
  GetRoleBindingsParams({
    this.userUuid,
    this.projectUUID,
    this.roleUuid,
    this.createdAt,
    this.updatedAt,
  });

  final String? userUuid;
  final ProjectUUID? projectUUID;
  final String? roleUuid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
