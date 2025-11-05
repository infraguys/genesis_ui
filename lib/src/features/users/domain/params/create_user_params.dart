final class CreateUserParams {
  CreateUserParams({
    required this.username,
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.description,
    this.surname,
    this.phone,
  });

  final String username;
  final String? firstName;
  final String? lastName;
  final String email;
  final String password;
  final String? description;
  final String? surname;
  final String? phone;
}
