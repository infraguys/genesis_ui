import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

final class GetRolesParams {
  const GetRolesParams({
    this.uuids,
    this.projectUUID,
  });

  final List<RoleUUID>? uuids;
  final ProjectUUID? projectUUID;
}
