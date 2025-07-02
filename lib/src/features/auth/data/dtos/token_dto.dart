import 'package:json_annotation/json_annotation.dart';

part 'token_dto.g.dart';

@JsonSerializable(createToJson: false)
class TokenDto {
  TokenDto({
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

  static DateTime _fromTimestamp(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp);

  final String accessToken;
  final String tokenType;
  @JsonKey(fromJson: _fromTimestamp)
  final DateTime expiresAt;
  final int expiresIn;
  final String idToken;
  final String refreshToken;
  final int refreshExpiresIn;
  final String scope;
}
