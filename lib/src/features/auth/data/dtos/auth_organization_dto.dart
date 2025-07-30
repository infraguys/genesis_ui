import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/common/shared_entities/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_organization_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class AuthOrganizationDto implements IDto<Organization> {
  AuthOrganizationDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.statusDto,
    required this.info,
  });

  factory AuthOrganizationDto.fromJson(Map<String, dynamic> json) => _$AuthOrganizationDtoFromJson(json);

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(unknownEnumValue: _StatusDto.unknown)
  final _StatusDto statusDto; // ignore: library_private_types_in_public_api
  final dynamic info;

  @override
  Organization toEntity() {
    return Organization(
      uuid: uuid,
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
    unknown => Status.unknown,
  };
}
