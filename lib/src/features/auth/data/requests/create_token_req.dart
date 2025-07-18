import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_token_req.g.dart';

@JsonSerializable(createFactory: false)
class CreateTokenReq implements IReq {
  CreateTokenReq(CreateTokenParams params) : username = params.username, password = params.password;

  @JsonKey(includeToJson: false)
  final String iamClientUuid = Env.iamClientUuid;
  final String grantType = Env.grantType;
  final String clientId = Env.clientId;
  final String clientSecret = Env.clientSecret;
  final String? scope = Env.scope;
  final int? ttl = Env.ttl;
  final int? refreshTtl = Env.refreshTtl;
  final String username;
  final String password;

  @override
  Map<String, dynamic> toJson() => _$CreateTokenReqToJson(this);
}
