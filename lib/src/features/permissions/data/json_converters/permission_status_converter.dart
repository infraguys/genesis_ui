import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:json_annotation/json_annotation.dart';

class PermissionStatusConverter implements JsonConverter<PermissionStatus, String?> {
  const PermissionStatusConverter();

  @override
  PermissionStatus fromJson(String? json) {
    return switch (json) {
      'ACTIVE' => .active,
      _ => .unknown,
    };
  }

  @override
  String? toJson(PermissionStatus? status) {
    return switch (status) {
      .active => 'ACTIVE',
      _ => null,
    };
  }
}