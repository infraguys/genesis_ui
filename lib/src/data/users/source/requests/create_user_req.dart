import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/domain/features/users/params/create_user_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_req.g.dart';

@JsonSerializable(createFactory: false)
final class CreateUserReq implements IReq {
  CreateUserReq._({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    this.surname,
    this.phone,
    this.description,
  });

  factory CreateUserReq.fromParams(CreateUserParams params) {
    return CreateUserReq._(
      username: params.username,
      description: params.description,
      password: params.password,
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
      phone: params.phone,
      surname: params.surname,
    );
  }

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? description;
  final String? surname;
  final String? phone;

  @override
  Map<String, dynamic> toJson() => _$CreateUserReqToJson(this);
}
