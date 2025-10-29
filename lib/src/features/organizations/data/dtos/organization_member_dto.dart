import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_member_dto.g.dart';

@JsonSerializable(constructor: '_')
class OrganizationMemberDto implements IDto<dynamic> {
  OrganizationMemberDto._({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.organizationLink,
    required this.userLink,
    required this.role,
  });

  factory OrganizationMemberDto.fromJson(Map<String, dynamic> json) => _$OrganizationMemberDtoFromJson(json);

  @JsonKey(name: 'uuid')
  final String id;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'organization')
  final String? organizationLink;
  @JsonKey(name: 'user')
  final String userLink;
  @JsonKey(name: 'role')
  final String role;

  @override
  toEntity() {
    // TODO: implement toEntity
    throw UnimplementedError();
  }
}
