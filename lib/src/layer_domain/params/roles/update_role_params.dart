import 'package:genesis/src/layer_domain/entities/permission.dart';

final class UpdateRoleParams {
  UpdateRoleParams({
    required this.uuid,
    required this.name,
    this.description,
    this.permissions,
  });

  final String uuid;
  final String name;
  final String? description;
  final List<Permission>? permissions;
}
