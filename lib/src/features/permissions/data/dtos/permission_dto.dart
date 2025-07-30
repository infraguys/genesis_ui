import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/common/shared_entities/permission.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
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

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final PermissionStatusDto status;

  @override
  Permission toEntity() {
    return Permission(
      uuid: uuid,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toPermissionStatus(),
    );
  }
}

@JsonEnum()
enum PermissionStatusDto {
  @JsonValue('ACTIVE')
  active;

  PermissionStatus toPermissionStatus() => switch (this) {
    active => PermissionStatus.active,
  };
}
