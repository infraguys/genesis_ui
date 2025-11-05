import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
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

  final UserID uuid;
  final String username;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserStatus status;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? phone;
  final String email;
  final bool emailVerified;
  final bool otpEnabled;

  bool get isActive => status == UserStatus.active;

  @override
  List<Object?> get props => [
    uuid,
    username,
    description,
    createdAt,
    updatedAt,
    status,
    firstName,
    lastName,
    surname,
    phone,
    email,
    emailVerified,
    otpEnabled,
  ];
}

// Copyable extension ----------

// extension UserCopyable on User {
//   User copyWith({
//     String? uuid,
//     String? username,
//     String? description,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     Status? status,
//     String? firstName,
//     String? lastName,
//     String? surname,
//     String? phone,
//     String? email,
//     bool? emailVerified,
//     bool? otpEnabled,
//     List<Role>? roles,
//     List<Organization>? organizations,
//   }) {
//     return User(
//       uuid: uuid ?? this.uuid,
//       username: username ?? this.username,
//       description: description ?? this.description,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       status: status ?? this.status,
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       surname: surname ?? this.surname,
//       phone: phone ?? this.phone,
//       email: email ?? this.email,
//       emailVerified: emailVerified ?? this.emailVerified,
//       otpEnabled: otpEnabled ?? this.otpEnabled,
//     );
//   }
// }

extension type UserID(String raw) {}

enum UserStatus { active, unknown }
