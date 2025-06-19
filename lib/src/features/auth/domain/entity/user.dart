class User {
  User({
    required this.uuid,
    required this.name,
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

  final int uuid;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String firstName;
  final String lastName;
  final String surname;
  final String? phone;
  final String email;
  final bool emailVerified;
  final bool otpEnabled;
}

///{
//     "user": {
//     "uuid": "00000000-0000-0000-0000-000000000000",
//     "name": "admin",
//     "description": "System administrator",
//     "created_at": "2025-05-15 11:01:57.056852",
//     "updated_at": "2025-05-15 11:01:57.056852",
//     "status": "ACTIVE",
//     "first_name": "Admin",
//     "last_name": "User",
//     "surname": "",
//     "phone": null,
//     "email": "admin@example.com",
//     "email_verified": false,
//     "otp_enabled": false
//     },
