import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class UserDto implements IDto<User> {
  UserDto({
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

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  @JsonKey(required: true)
  final String uuid;
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

  @override
  User toEntity() {
    return User(
      uuid: uuid,
      name: name,
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
}
