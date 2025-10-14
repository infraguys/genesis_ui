import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_dto.g.dart';

@JsonSerializable(constructor: '_')
class OrganizationDto implements IDto<Organization> {
  OrganizationDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.info,
  });

  factory OrganizationDto.fromJson(Map<String, dynamic> json) => _$OrganizationDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final OrganizationID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status')
  final OrganizationStatusDto status;
  @JsonKey(name: 'info')
  final dynamic info;

  @override
  Organization toEntity() {
    return Organization(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toOrganizationStatus(),
    );
  }

  static OrganizationID _toID(String json) => OrganizationID(json);
}

@JsonEnum()
enum OrganizationStatusDto {
  @JsonValue('ACTIVE')
  active;

  Status toOrganizationStatus() => switch (this) {
    active => Status.active,
  };
}
