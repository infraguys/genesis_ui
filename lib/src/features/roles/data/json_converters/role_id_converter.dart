import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:json_annotation/json_annotation.dart';

class RoleIdConverter extends JsonConverter<RoleID, String> {
  const RoleIdConverter();

  @override
  RoleID fromJson(String json) => RoleID(json);

  @override
  String toJson(RoleID object) => object.raw;
}