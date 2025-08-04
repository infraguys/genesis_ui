import 'package:genesis/src/features/common/shared_entities/permission.dart';

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
