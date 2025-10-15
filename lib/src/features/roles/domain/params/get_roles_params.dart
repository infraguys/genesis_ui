import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class GetRolesParams {
  const GetRolesParams({
    this.uuids,
    this.projectUUID,
  });

  final List<RoleUUID>? uuids;
  final ProjectID? projectUUID;
}
