import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_dto.g.dart';

@JsonSerializable(constructor: '_')
final class PermissionDto implements IDto<Permission> {
  PermissionDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory PermissionDto.fromJson(Map<String, dynamic> json) => _$PermissionDtoFromJson(json);

  @JsonKey(name: 'uuid')
  final String uuid;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final PermissionStatus status; // ignore: library_private_types_in_public_api

  @override
  Permission toEntity() {
    return Permission(
      uuid: PermissionUUID(uuid),
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
    );
  }

  static PermissionStatus _toStatusFromJson(String json) => switch (json) {
    'ACTIVE' => PermissionStatus.active,
    _ => PermissionStatus.unknown,
  };
}
