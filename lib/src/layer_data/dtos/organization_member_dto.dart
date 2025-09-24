import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_member_dto.g.dart';

@JsonSerializable(constructor: '_')
class OrganizationMemberDto implements IDto<dynamic> {
  OrganizationMemberDto._({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.organizationsSource,
    required this.userSource,
    required this.role,
  });

  factory OrganizationMemberDto.fromJson(Map<String, dynamic> json) => _$OrganizationMemberDtoFromJson(json);

  final String uuid;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  @JsonKey(name: 'organization')
  final String? organizationsSource;
  @JsonKey(name: 'user')
  final String userSource;
  final String role;

  static DateTime _fromIsoStringToDateTime(String value) => DateTime.parse(value);

  @override
  toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
