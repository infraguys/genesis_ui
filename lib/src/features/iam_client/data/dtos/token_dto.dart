import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable(constructor: '_')
class TokenDto {
  TokenDto._({
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
    required this.idToken,
    required this.refreshToken,
    required this.scope,
    required this.expiresIn,
    required this.refreshExpiresIn,
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) => _$TokenDtoFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_at', fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime expiresAt;
  @JsonKey(name: 'expires_in')
  final int expiresIn;
  @JsonKey(name: 'id_token')
  final String idToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'refresh_expires_in')
  final int refreshExpiresIn;
  @JsonKey(name: 'scope')
  final String scope;
}
