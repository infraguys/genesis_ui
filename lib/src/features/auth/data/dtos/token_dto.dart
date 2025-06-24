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

  static DateTime _fromTimestamp(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp);

  final String accessToken;
  @JsonKey(fromJson: _fromTimestamp)
  final DateTime expiresAt;
  final String idToken;
  final String refreshToken;
  final String scope;
  final String tokenType;
}
