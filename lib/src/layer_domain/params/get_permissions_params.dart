import 'package:genesis/src/layer_domain/entities/status.dart';

final class GetPermissionsParams {
  const GetPermissionsParams({
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
