import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/domain/features/users/params/update_user_params.dart';

class UpdateUserReq implements IReq {
  UpdateUserReq({
    required this.username,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.surname,
    required this.phone,
    required this.email,
  });

  factory UpdateUserReq.fromParams(UpdateUserParams params) {
    return UpdateUserReq(
      username: params.username,
      description: params.description,
      firstName: params.firstName,
      lastName: params.lastName,
      surname: params.surname,
      phone: params.phone,
      email: params.email,
    );
  }

  final String username;
  final String description;
  final String firstName;
  final String lastName;
  final String surname;
  final String phone;
  final String email;

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'description': description,
      'first_name': firstName,
      'last_name': lastName,
      'surname': surname,
      'phone': phone,
      'email': email,
    };
  }
}
