import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/data/auth/dtos/auth_user_dto.dart';
import 'package:genesis/src/data/auth/dtos/organization_dto.dart';
import 'package:genesis/src/domain/features/auth/auth_entities/iam_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'iam_client_dto.g.dart';

@JsonSerializable(createToJson: false)
class IamClientDto implements IDto<IamClient> {
  IamClientDto({
    required this.user,
    required this.organizations,
  });

  factory IamClientDto.fromJson(Map<String, dynamic> json) => _$IamClientDtoFromJson(json);

  final AuthUserDto user;
  @JsonKey(name: 'organization')
  final List<OrganizationDto> organizations;

  @override
  IamClient toEntity() {
    return IamClient(
      user: user.toEntity(),
      organizations: organizations.map((it) => it.toEntity()).toList(),
    );
  }
}
