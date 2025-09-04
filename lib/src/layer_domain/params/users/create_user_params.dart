class CreateUserParams {
  CreateUserParams({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.description,
    this.surname,
    this.phone,
  });

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? description;
  final String? surname;
  final String? phone;
}
