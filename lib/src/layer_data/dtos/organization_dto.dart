import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_dto.g.dart';

@JsonSerializable(constructor: '_')
class OrganizationDto implements IDto<Organization> {
  OrganizationDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.info,
  });

  factory OrganizationDto.fromJson(Map<String, dynamic> json) => _$OrganizationDtoFromJson(json);

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final OrganizationStatusDto status;
  final dynamic info;

  @override
  Organization toEntity() {
    return Organization(
      uuid: OrganizationUUID(uuid),
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toOrganizationStatus(),
    );
  }
}

@JsonEnum()
enum OrganizationStatusDto {
  @JsonValue('ACTIVE')
  active;

  Status toOrganizationStatus() => switch (this) {
    active => Status.active,
  };
}
