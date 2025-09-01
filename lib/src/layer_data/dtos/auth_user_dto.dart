import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
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
    required this.statusDto,
    required this.firstName,
    required this.lastName,
    required this.surname,
    required this.phone,
    required this.email,
    required this.emailVerified,
    required this.otpEnabled,
    // required this.organizations,
  });

  factory AuthUserDto.fromJson(Map<String, dynamic> json) {
    final modifiedJson = Map.of(json);
    modifiedJson['username'] ??= json['name'];
    return _$AuthUserDtoFromJson(modifiedJson);
  }

  final String uuid;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', unknownEnumValue: _StatusDto.unknown)
  final _StatusDto statusDto; // ignore: library_private_types_in_public_api
  final String username;
  final String firstName;
  final String lastName;
  final String surname;
  final String? phone;
  final String email;
  final bool emailVerified;
  final bool otpEnabled;

  @override
  User toEntity() {
    return User(
      uuid: UserUUID(uuid),
      username: username,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: statusDto.toStatus(),
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
enum _StatusDto {
  @JsonValue('ACTIVE')
  active,
  unknown;

  Status toStatus() => switch (this) {
    active => Status.active,
    unknown => Status.unknown,
  };
}
