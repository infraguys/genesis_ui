import 'package:genesis/src/layer_domain/entities/user.dart';

class UpdateUserParams {
  UpdateUserParams({
    required this.uuid,
    this.username,
    this.description,
    this.firstName,
    this.lastName,
    this.surname,
    this.phone,
    this.email,
  });

  final UserUUID uuid;
  final String? username;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? phone;
  final String? email;
}
