import 'package:genesis/src/features/users/data/dtos/user_dto.dart';
import 'package:genesis/src/features/users/data/dtos/user_role_dto.dart';
import 'package:genesis/src/features/users/data/requests/change_user_password_req.dart';
import 'package:genesis/src/features/users/data/requests/create_user_req.dart';
import 'package:genesis/src/features/users/data/requests/update_user_req.dart';

abstract interface class IUsersApi {
  Future<List<UserDto>> getUsers();

  Future<UserDto> getUser();

  Future<UserDto> createUser(CreateUserReq req);

  Future<UserDto> updateUser(UpdateUserReq req);

  Future<void> deleteUser(String userUuid);

  Future<UserDto> changeUserPassword(ChangeUserPasswordReq req);

  Future<UserDto> resetUserPassword();

  Future<UserDto> confirmEmail(String userUuid);

  Future<List<UserRoleDto>> getUserRoles(String userUuid);
}
