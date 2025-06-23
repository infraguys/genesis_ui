import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_token_req.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class CreateTokenReq implements IReq {
  CreateTokenReq({
    required this.iamClientUuid,
    required this.grantType,
    required this.clientId,
    required this.clientSecret,
    required this.username,
    required this.password,
    required this.scope,
    required this.ttl,
    required this.refreshTtl,
  });

  factory CreateTokenReq.fromParams(CreateTokenParams params) {
    return CreateTokenReq(
      iamClientUuid: params.iamClientUuid,
      clientId: params.clientId,
      username: params.username,
      password: params.password,
      clientSecret: params.clientSecret,
      grantType: params.grantType,
      ttl: params.ttl,
      refreshTtl: params.refreshTtl,
      scope: params.scope,
    );
  }

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
  Map<String, dynamic> toJson() => _$CreateTokenReqToJson(this);
}
