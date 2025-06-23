import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable(createToJson: false)
class TokenDto {
  TokenDto({
    required this.accessToken,
    required this.expiresAt,
    required this.idToken,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
  });

  factory TokenDto.fromJson(Map<String, dynamic> json) => _$TokenDtoFromJson(json);

  final String accessToken;
  final int expiresAt;
  final String idToken;
  final String refreshToken;
  final String scope;
  final String tokenType;
}
