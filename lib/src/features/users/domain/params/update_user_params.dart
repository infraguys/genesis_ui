import 'package:genesis/src/features/users/domain/entities/user.dart';

final class UpdateUserParams {
  UpdateUserParams({
    required this.id,
    this.username,
    this.description,
    this.firstName,
    this.lastName,
    this.surname,
    this.phone,
    this.email,
  });

  final UserID id;
  final String? username;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? phone;
  final String? email;
}
