final class GetUsersParams {
  GetUsersParams({
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.salt,
    required this.secretHash,
    required this.firstName,
    required this.lastName,
    required this.surname,
    required this.email,
    required this.phone,
    required this.emailVerified,
    required this.password,
  });

  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? salt;
  final String? secretHash;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? email;
  final String? phone;
  final bool emailVerified;
  final String? password;
}
