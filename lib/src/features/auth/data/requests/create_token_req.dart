import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_token_req.g.dart';

@JsonSerializable(createFactory: false)
class CreateTokenReq implements IReq {
  factory CreateTokenReq(CreateTokenParams params) {
    return CreateTokenReq._(
      iamClientUuid: Env.iamClientUuid,
      clientId: Env.clientId,
      clientSecret: Env.clientSecret,
      grantType: Env.grantType,
      ttl: Env.ttl,
      refreshTtl: Env.refreshTtl,
      scope: Env.scope,
      username: params.username,
      password: params.password,
    );
  }

  CreateTokenReq._({
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
