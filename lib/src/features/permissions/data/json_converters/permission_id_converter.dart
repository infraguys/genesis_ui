import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:json_annotation/json_annotation.dart';

class PermissionIdConverter extends JsonConverter<PermissionID, String> {
  const PermissionIdConverter();

  @override
  PermissionID fromJson(String json) => PermissionID(json);

  @override
  String toJson(PermissionID object) => object.raw;
}