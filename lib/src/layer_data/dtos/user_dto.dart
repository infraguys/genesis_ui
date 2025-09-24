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

  @JsonKey(required: true)
  final String uuid;
  final String description;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  final AuthUserDtoStatus status;
  final String username;
  final String firstName;
  final String lastName;
  final String surname;
  final String? phone;
  final String email;
  final bool emailVerified;
  final bool otpEnabled;

  static DateTime _fromIsoStringToDateTime(String value) => DateTime.parse(value);

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
