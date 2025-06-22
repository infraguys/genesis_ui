import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_token_params.g.dart';

@JsonSerializable(createFactory: false, fieldRename: FieldRename.snake)
class CreateTokenParams implements IReq {
  CreateTokenParams({
    required this.iamClientUuid,
    required this.grantType,
    required this.clientId,
    required this.clientSecret,
    required this.username,
    required this.password,
    this.scope,
    this.ttl,
    this.refreshTtl,
  });

  @JsonKey(includeToJson: false)
  final String iamClientUuid;
  final String grantType;
  final String clientId;
  final String clientSecret;
  final String username;
  final String password;
  final String? scope;
  final int? ttl;
  final int? refreshTtl;

  @override
  Map<String, dynamic> toJson() => _$CreateTokenParamsToJson(this);
}
