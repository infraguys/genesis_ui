import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/user/domain/params/change_user_password_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'change_user_password_req.g.dart';

@JsonSerializable(createFactory: false)
class ChangeUserPasswordReq implements IReq {
  ChangeUserPasswordReq._({
    required this.uuid,
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangeUserPasswordReq.fromParams(ChangeUserPasswordParams params) {
    return ChangeUserPasswordReq._(
      uuid: params.uuid,
      oldPassword: params.oldPassword,
      newPassword: params.newPassword,
    );
  }

  @JsonKey(includeToJson: false)
  final String uuid;
  final String oldPassword;
  final String newPassword;

  @override
  Map<String, dynamic> toJson() => _$ChangeUserPasswordReqToJson(this);
}
