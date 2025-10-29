import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_dto.g.dart';

@JsonSerializable(constructor: '_')
final class PermissionDto implements IDto<Permission> {
  PermissionDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory PermissionDto.fromJson(Map<String, dynamic> json) => _$PermissionDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final PermissionID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final PermissionStatus status;

  @override
  Permission toEntity() {
    return Permission(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
    );
  }

  static PermissionID _toID(String json) => PermissionID(json);

  static PermissionStatus _toStatusFromJson(String json) => switch (json) {
    'ACTIVE' => PermissionStatus.active,
    _ => PermissionStatus.unknown,
  };
}
