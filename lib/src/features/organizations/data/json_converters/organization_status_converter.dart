import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:json_annotation/json_annotation.dart';

class OrganizationStatusConverter implements JsonConverter<OrganizationStatus, String?> {
  const OrganizationStatusConverter();

  @override
  OrganizationStatus fromJson(String? json) {
    return switch (json) {
      'ACTIVE' => .active,
      _ => .unknown,
    };
  }

  @override
  String? toJson(OrganizationStatus? status) {
    return switch (status) {
      .active => 'ACTIVE',
      _ => null,
    };
  }
}