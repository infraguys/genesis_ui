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

  final String uuid;
  final String? username;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? phone;
  final String? email;

  @override
  String toString() {
    return 'UpdateUserParams(uuid: $uuid, username: $username, description: $description, firstName: $firstName, lastName: $lastName, surname: $surname, phone: $phone, email: $email)';
  }
}
