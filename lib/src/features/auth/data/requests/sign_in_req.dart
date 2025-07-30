import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/features/auth/domain/params/sign_in_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_req.g.dart';

@JsonSerializable(createFactory: false)
class SignInReq {
  SignInReq(SignInParams params) : username = params.username, password = params.password;

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

  Map<String, dynamic> toJson() => _$SignInReqToJson(this);
}
