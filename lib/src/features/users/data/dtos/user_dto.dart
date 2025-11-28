import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(constructor: '_')
class UserDto implements IDto<User> {
  UserDto._({
    required this.id,
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

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final UserID id;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final UserStatus status;
  @JsonKey(name: 'username', readValue: _readUsername)
  final String username;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'surname')
  final String? surname;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'email_verified')
  final bool emailVerified;
  @JsonKey(name: 'otp_enabled')
  final bool otpEnabled;

  @override
  User toEntity() {
    return User(
      uuid: id,
      username: username,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      firstName: firstName,
      lastName: lastName,
      surname: surname,
      phone: phone,
      email: email,
      emailVerified: emailVerified,
      otpEnabled: otpEnabled,
    );
  }

  static Object? _readUsername(Map<dynamic, dynamic> json, String _) => json['username'] ?? json['name'];

  static UserID _toID(String json) => UserID(json);

  static UserStatus _toStatusFromJson(String json) => switch (json) {
    'ACTIVE' => .active,
    _ => .unknown,
  };
}
