import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:json_annotation/json_annotation.dart';

class RoleStatusConverter implements JsonConverter<RoleStatus, String?> {
  const RoleStatusConverter();

  @override
  RoleStatus fromJson(String? json) {
    return switch (json) {
      'ACTIVE' => .active,
      _ => .unknown,
    };
  }

  @override
  String? toJson(RoleStatus? status) {
    return switch (status) {
      .active => 'ACTIVE',
      _ => null,
    };
  }
}