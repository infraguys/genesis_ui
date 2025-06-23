import 'package:genesis/src/features/auth/data/dto/user_dto.dart';

abstract interface class IRemoteUserApi {
  Future<UserDto> createUser();

  Future<UserDto> getUser();

  Future<UserDto> updateUser();

  Future<UserDto> deleteUser();

  Future<UserDto> changeUserPassword();

  Future<UserDto> resetUserPassword();

  Future<UserDto> confirmUserEmail();

  Future<List<UserDto>> getUsers();
}
