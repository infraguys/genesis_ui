class User {
  User({
    required this.uuid,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.surname,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.status,
    this.emailVerified = false,
    this.otpEnabled = false,
  });

  String uuid;
  String username;
  String firstName;
  String lastName;
  String surname;
  String email;
  String createdAt;
  String updatedAt;
  String description;
  String status;
  bool emailVerified;
  bool otpEnabled;
}
