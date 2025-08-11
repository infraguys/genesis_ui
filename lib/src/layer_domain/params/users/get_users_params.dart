final class GetUsersParams {
  GetUsersParams({
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.salt,
    this.secretHash,
    this.firstName,
    this.lastName,
    this.surname,
    this.email,
    this.phone,
    this.emailVerified,
    this.password,
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
  final bool? emailVerified;
  final String? password;
}
