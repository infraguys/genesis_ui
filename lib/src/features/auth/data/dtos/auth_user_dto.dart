import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/auth_organization_dto.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_user_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class AuthUserDto implements IDto<User> {
  AuthUserDto._({
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
    required this.organizations,
  });

  factory AuthUserDto.fromJson(Map<String, dynamic> json) {
    final modifiedJson = Map.of(json);
    modifiedJson['username'] ??= json['name'];
    return _$AuthUserDtoFromJson(modifiedJson);
  }

  @JsonKey(required: true)
  final String uuid;
  final String description;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  final UserDtoStatus status;
  final String username;
  final String firstName;
  final String lastName;
  final String surname;
  final String? phone;
  final String email;
  final bool emailVerified;
  final bool otpEnabled;
  @JsonKey(name: 'organization', defaultValue: [])
  final List<AuthOrganizationDto> organizations;

  static DateTime _fromIsoStringToDateTime(String value) => DateTime.parse(value);

  @override
  User toEntity() {
    return User(
      uuid: uuid,
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
      // todo: add organizations to User entity when implemented
    );
  }
}

@JsonEnum()
enum UserDtoStatus {
  @JsonValue('ACTIVE')
  active;

  UserStatus toUserStatus() => switch (this) {
    active => UserStatus.active,
  };
}
