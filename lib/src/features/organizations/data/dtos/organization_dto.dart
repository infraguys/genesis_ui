import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/common/shared_entities/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
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
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  final OrganizationStatusDto status;
  final dynamic info;

  static DateTime _fromIsoStringToDateTime(String value) => DateTime.parse(value);

  @override
  Organization toEntity() {
    return Organization(
      uuid: uuid,
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
