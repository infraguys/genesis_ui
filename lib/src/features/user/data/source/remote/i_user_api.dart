import 'package:genesis/src/features/user/data/dtos/user_feat_role_dto.dart';
import 'package:genesis/src/features/user/data/dtos/user_feat_user_dto.dart';
import 'package:genesis/src/features/user/data/requests/change_user_password_req.dart';
import 'package:genesis/src/features/user/data/requests/create_user_req.dart';
import 'package:genesis/src/features/user/data/requests/update_user_req.dart';

abstract interface class IUserApi {
  Future<UserFeatUserDto> getUser();

  Future<UserFeatUserDto> createUser(CreateUserReq req);

  Future<UserFeatUserDto> updateUser(UpdateUserReq req);

  Future<void> deleteUser(String userUuid);

  Future<UserFeatUserDto> changeUserPassword(ChangeUserPasswordReq req);

  Future<UserFeatUserDto> resetUserPassword();

  Future<UserFeatUserDto> confirmEmail(String userUuid);

  Future<List<UserFeatRoleDto>> getUserRoles(String userUuid);
}
