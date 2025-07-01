import 'package:genesis/src/features/users/data/dtos/user_dto.dart';

abstract interface class IUsersApi {
  Future<List<UserDto>> getUsers();

  Future<UserDto> getUser();

  Future<UserDto> createUser();

  Future<UserDto> updateUser();

  Future<UserDto> deleteUser();

  Future<UserDto> changeUserPassword();

  Future<UserDto> resetUserPassword();

  Future<UserDto> confirmEmail();
}
