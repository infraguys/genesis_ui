class UpdateUserParams {
  UpdateUserParams({
    required this.username,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.surname,
    required this.phone,
    required this.email,
  });

  final String username;
  final String description;
  final String firstName;
  final String lastName;
  final String surname;
  final String phone;
  final String email;

  @override
  String toString() {
    return 'UpdateUserParams(username: $username, description: $description, firstName: $firstName, lastName: $lastName, surname: $surname, phone: $phone, email: $email)';
  }
}
