import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';
import 'package:json_annotation/json_annotation.dart';

class PermissionBindingIdConverter extends JsonConverter<PermissionBindingID, String> {
  const PermissionBindingIdConverter();

  @override
  PermissionBindingID fromJson(String json) => PermissionBindingID(json);

  @override
  String toJson(PermissionBindingID object) => object.raw;
}