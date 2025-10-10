import 'package:json_annotation/json_annotation.dart';

part 'client_introspection_dto.g.dart';

@JsonSerializable(constructor: '_', explicitToJson: true)
final class ClientIntrospectionDto {
  const ClientIntrospectionDto._({
    required this.projectId,
    required this.permissions,
  });

  factory ClientIntrospectionDto.fromJson(Map<String, dynamic> json) => _$ClientIntrospectionDtoFromJson(json);

  @JsonKey(name: 'project_id')
  final String? projectId;
  @JsonKey(name: 'permissions')
  final Set<String> permissions;
}
