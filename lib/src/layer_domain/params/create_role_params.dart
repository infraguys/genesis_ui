import 'package:genesis/src/layer_domain/entities/permission.dart';

final class CreateRoleParams {
  const CreateRoleParams({
    required this.name,
    required this.permissions,
    this.description,
  });

  final String name;
  final String? description;
  final List<Permission> permissions;
}
