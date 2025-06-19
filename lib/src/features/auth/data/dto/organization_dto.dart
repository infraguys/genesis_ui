import 'package:json_annotation/json_annotation.dart';

part 'organization_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class OrganizationDto {
  OrganizationDto({
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
  final String createdAt;
  final String updatedAt;
  final String status;
  final dynamic info;
}
