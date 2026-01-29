import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';
import 'package:json_annotation/json_annotation.dart';

class RoleBindingIdConverter extends JsonConverter<RoleBindingID, String> {
  const RoleBindingIdConverter();

  @override
  RoleBindingID fromJson(String json) => RoleBindingID(json);

  @override
  String toJson(RoleBindingID object) => object.raw;
}