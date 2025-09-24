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

  final String accessToken;
  final String tokenType;
  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime expiresAt;
  final int expiresIn;
  final String idToken;
  final String refreshToken;
  final int refreshExpiresIn;
  final String scope;
}
