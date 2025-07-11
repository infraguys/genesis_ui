import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_req.g.dart';

@JsonSerializable(createFactory: false)
class UpdateUserReq implements IReq {
  UpdateUserReq._({
    required this.uuid,
    this.username,
    this.description,
    this.firstName,
    this.lastName,
    this.surname,
    this.phone,
    this.email,
  });

  factory UpdateUserReq.fromParams(UpdateUserParams params) {
    return UpdateUserReq._(
      uuid: params.uuid,
      username: params.username,
      description: params.description,
      firstName: params.firstName,
      lastName: params.lastName,
      surname: params.surname,
      phone: params.phone,
      email: params.email,
    );
  }

  final String uuid;
  final String? username;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? phone;
  final String? email;

  @override
  Map<String, dynamic> toJson() => _$UpdateUserReqToJson(this);
}
