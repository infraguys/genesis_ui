import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(constructor: '_')
class UserDto implements IDto<User> {
  UserDto._({
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

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final modifiedJson = Map.of(json);
    modifiedJson['username'] ??= json['name'];
    return _$UserDtoFromJson(modifiedJson);
  }

  @JsonKey(name: 'uuid', required: true)
  final String uuid;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  final AuthUserDtoStatus status;
  @JsonKey(name: 'username', readValue: _readUsername)
  final String username;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'surname')
  final String surname;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'email_verified')
  final bool emailVerified;
  @JsonKey(name: 'otp_enabled')
  final bool otpEnabled;


  static Object? _readUsername(Map<dynamic, dynamic> json, String _) => json['username'] ?? json['name'];


  @override
  User toEntity() {
    return User(
      uuid: UserUUID(uuid),
      username: username,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toUserStatus(),
      firstName: firstName,
      lastName: lastName,
      surname: surname,
      phone: phone,
      email: email,
      emailVerified: emailVerified,
      otpEnabled: otpEnabled,
    );
  }
}

@JsonEnum()
enum AuthUserDtoStatus {
  @JsonValue('ACTIVE')
  active;

  Status toUserStatus() => switch (this) {
    active => Status.active,
  };
}
