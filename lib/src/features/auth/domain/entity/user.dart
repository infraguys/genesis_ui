class User {
  User({
    required this.uuid,
    required this.username,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.surname,
    required this.phone,
    required this.email,
    required this.emailVerified,
    required this.otpEnabled,
  });

  final String uuid;
  final String username;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserStatus status;
  final String firstName;
  final String lastName;
  final String? surname;
  final String? phone;
  final String email;
  final bool emailVerified;
  final bool otpEnabled;
}

enum UserStatus { active }
