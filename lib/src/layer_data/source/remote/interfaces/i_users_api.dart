import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/dtos/user_role_dto.dart';
import 'package:genesis/src/layer_data/requests/users/change_user_password_req.dart';
import 'package:genesis/src/layer_data/requests/users/confirm_email_req.dart';
import 'package:genesis/src/layer_data/requests/users/create_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/delete_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_users_req.dart';
import 'package:genesis/src/layer_data/requests/users/update_user_req.dart';

abstract interface class IUsersApi {
  Future<List<UserDto>> getUsers(GetUsersReq req);

  Future<UserDto> getUser(GetUserReq req);

  Future<UserDto> createUser(CreateUserReq req);

  Future<UserDto> updateUser(UpdateUserReq req);

  Future<void> deleteUser(DeleteUserReq req);

  Future<UserDto> changeUserPassword(ChangeUserPasswordReq req);

  Future<UserDto> resetUserPassword();

  Future<UserDto> confirmEmail(ConfirmEmailReq req);

  Future<List<UserRoleDto>> getUserRoles(String userUuid);
}
