import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:json_annotation/json_annotation.dart';

class OrganizationIdConverter extends JsonConverter<OrganizationID, String> {
  const OrganizationIdConverter();

  @override
  OrganizationID fromJson(String json) => OrganizationID(json);

  @override
  String toJson(OrganizationID object) => object.raw;
}