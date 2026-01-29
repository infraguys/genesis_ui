import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/organizations/data/json_converters/organization_id_converter.dart';
import 'package:genesis/src/features/organizations/data/json_converters/organization_status_converter.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
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

  @OrganizationIdConverter()
  @JsonKey(name: 'uuid')
  final OrganizationID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @OrganizationStatusConverter()
  @JsonKey(name: 'status')
  final OrganizationStatus status;
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
      status: status,
    );
  }
}
