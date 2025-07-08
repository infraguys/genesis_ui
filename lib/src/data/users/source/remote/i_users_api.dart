import 'package:genesis/src/data/users/dtos/user_dto.dart';
import 'package:genesis/src/data/users/dtos/users_role_dto.dart';
import 'package:genesis/src/data/users/source/requests/create_user_req.dart';

abstract interface class IUsersApi {
  Future<List<UserDto>> getUsers();

  Future<UserDto> getUser();

  Future<UserDto> createUser(CreateUserReq req);

  Future<UserDto> updateUser();

  Future<void> deleteUser(String userUuid);

  Future<UserDto> changeUserPassword(String userUuid);

  Future<UserDto> resetUserPassword();

  Future<UserDto> confirmEmail(String userUuid);

  Future<List<UsersRoleDto>> getUserRoles(String userUuid);
}
