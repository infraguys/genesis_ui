import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/interfaces/i_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'iam_client_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class IamClientDto implements IDto<IamClient> {
  IamClientDto({
    required this.accessToken,
    required this.expiresAt,
    required this.idToken,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
  });

  factory IamClientDto.fromJson(Map<String, dynamic> json) => _$IamClientDtoFromJson(json);

  final String accessToken;
  final int expiresAt;
  final String idToken;
  final String refreshToken;
  final String scope;
  final String tokenType;

  @override
  IamClient toEntity() {
    return IamClient(
      accessToken: accessToken,
      expiresAt: expiresAt,
      idToken: idToken,
      refreshToken: refreshToken,
      scope: scope,
      tokenType: tokenType,
    );
  }
}
