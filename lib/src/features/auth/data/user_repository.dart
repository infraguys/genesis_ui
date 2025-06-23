import 'package:genesis/src/features/auth/data/requests/sign_up_req.dart';
import 'package:genesis/src/features/auth/data/source/i_remote_user_api.dart';
import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';
import 'package:genesis/src/features/auth/domain/repositories/i_user_repository.dart';

final class UserRepository implements IUserRepository {
  UserRepository(this._userApi);

  final IRemoteUserApi _userApi;

  @override
  Future<User> singUp(SignUpParams params) async {
    final req = SignUpReq.fromParams(params);
    final dto = await _userApi.signUp(req);
    return dto.toEntity();
  }

  @override
  Future<User> changeUserPassword() {
    // TODO: implement changeUserPassword
    throw UnimplementedError();
  }

  @override
  Future<User> confirmUserEmail() {
    // TODO: implement confirmUserEmail
    throw UnimplementedError();
  }

  @override
  Future<User> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<User> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
