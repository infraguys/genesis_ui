import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_req.g.dart';

@JsonSerializable(createFactory: false)
class SignUpReq implements IReq {
  SignUpReq({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    this.surname,
    this.phone,
    this.description,
    this.status,
    this.emailVerified,
    this.otpEnabled,
  });

  factory SignUpReq.fromParams(SignUpParams params) {
    return SignUpReq(
      username: params.username,
      description: params.description,
      password: params.password,
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
      phone: params.phone,
      status: params.status,
      surname: params.surname,
    );
  }

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? description;
  final String? status;
  final String? surname;
  final String? phone;
  final bool? emailVerified;
  final bool? otpEnabled;

  @override
  Map<String, dynamic> toJson() => _$SignUpReqToJson(this);
}
