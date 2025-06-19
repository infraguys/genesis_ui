import 'package:genesis/src/features/auth/data/dto/organization_dto.dart';
import 'package:genesis/src/features/auth/data/dto/user_dto.dart';
import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/entity/organization.dart';
import 'package:genesis/src/interfaces/i_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'iam_client_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class IamClientDto implements IDto<IamClient> {
  IamClientDto({required this.user, required this.organizations});

  factory IamClientDto.fromJson(Map<String, dynamic> json) => _$IamClientDtoFromJson(json);

  final UserDto user;
  @JsonKey(name: 'organization')
  final List<OrganizationDto> organizations;

  Organization _organizationToEntity(OrganizationDto it) {
    return it.toEntity();
  }

  @override
  IamClient toEntity() {
    return IamClient(
      user: user.toEntity(),
      organizations: organizations.map(_organizationToEntity).toList(),
    );
  }
}
