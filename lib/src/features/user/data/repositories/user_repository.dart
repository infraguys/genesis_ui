import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/user/data/requests/change_user_password_req.dart';
import 'package:genesis/src/features/user/data/requests/create_user_req.dart';
import 'package:genesis/src/features/user/data/requests/update_user_req.dart';
import 'package:genesis/src/features/user/data/source/remote/i_user_api.dart';
import 'package:genesis/src/features/user/domain/i_user_repository.dart';
import 'package:genesis/src/features/user/domain/params/change_user_password_params.dart';
import 'package:genesis/src/features/user/domain/params/create_user_params.dart';
import 'package:genesis/src/features/user/domain/params/update_user_params.dart';

final class UserRepository implements IUserRepository {
  UserRepository(this._userApi);

  final IUserApi _userApi;

  @override
  Future<User> changeUserPassword(ChangeUserPasswordParams params) async {
    final req = ChangeUserPasswordReq.fromParams(params);
    final dto = await _userApi.changeUserPassword(req);
    return dto.toEntity();
  }

  @override
  Future<User> confirmEmail() {
    // TODO: implement confirmEmail
    throw UnimplementedError();
  }

  @override
  Future<User> createUser(CreateUserParams params) async {
    final req = CreateUserReq.fromParams(params);
    final dto = await _userApi.createUser(req);
    return dto.toEntity();
  }

  @override
  Future<void> deleteUser(String userUuid) async {
    await _userApi.deleteUser(userUuid);
  }

  @override
  Future<User> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(UpdateUserParams params) async {
    final req = UpdateUserReq.fromParams(params);
    final dto = await _userApi.updateUser(req);
    return dto.toEntity();
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
