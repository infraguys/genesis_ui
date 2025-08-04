import 'package:genesis/src/layer_domain/entities/permission.dart';

final class CreateRoleParams {
  const CreateRoleParams({
    required this.name,
    required this.permission,
    this.description,
  });

  final String name;
  final String? description;
  final Permission permission;
}
