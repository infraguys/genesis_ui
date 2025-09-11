import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
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
    required this.statusDto,
  });

  factory PermissionDto.fromJson(Map<String, dynamic> json) => _$PermissionDtoFromJson(json);

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', unknownEnumValue: _StatusDto.unknown)
  final _StatusDto statusDto; // ignore: library_private_types_in_public_api

  @override
  Permission toEntity() {
    return Permission(
      uuid: PermissionUUID(uuid),
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: statusDto.toStatus(),
    );
  }
}

@JsonEnum()
enum _StatusDto {
  @JsonValue('ACTIVE')
  active,
  unknown;

  Status toStatus() => switch (this) {
    active => Status.active,
    _ => Status.unknown,
  };
}
