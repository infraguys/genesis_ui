import 'package:genesis/src/features/common/shared_entities/status.dart';

final class GetPermissionsParams {
  GetPermissionsParams({
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Status? status;
}
