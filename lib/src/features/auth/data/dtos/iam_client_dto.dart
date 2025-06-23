import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/organization_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/user_dto.dart';
import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'iam_client_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class IamClientDto implements IDto<IamClient> {
  IamClientDto({
    required this.user,
    required this.organizations,
  });

  factory IamClientDto.fromJson(Map<String, dynamic> json) => _$IamClientDtoFromJson(json);

  final UserDto user;
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
