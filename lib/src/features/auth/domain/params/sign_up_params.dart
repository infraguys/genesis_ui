class SignUpParams {
  SignUpParams({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.description,
    this.status,
    this.surname,
    this.phone,
    this.emailVerified,
    this.otpEnabled,
  });

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? description;
  final String? status;
  final String? surname;
  final String? phone;
  final bool? emailVerified;
  final bool? otpEnabled;
}
