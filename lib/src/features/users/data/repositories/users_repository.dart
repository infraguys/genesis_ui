import 'dart:async';

import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/data/requests/change_user_password_req.dart';
import 'package:genesis/src/features/users/data/requests/create_user_req.dart';
import 'package:genesis/src/features/users/data/requests/update_user_req.dart';
import 'package:genesis/src/features/users/data/source/remote/i_users_api.dart';
import 'package:genesis/src/features/users/domain/params/change_user_password_params.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._usersApi);

  final IUsersApi _usersApi;

  @override
  Future<List<User>> getUsers() async {
    final listOfUserDto = await _usersApi.getUsers();
    return listOfUserDto.map((it) => it.toEntity()).toList();
  }

  @override
  Future<User> changeUserPassword(ChangeUserPasswordParams params) async {
    final req = ChangeUserPasswordReq.fromParams(params);
    final dto = await _usersApi.changeUserPassword(req);
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
    final dto = await _usersApi.createUser(req);
    return dto.toEntity();
  }

  @override
  Future<void> deleteUser(String userUuid) async {
    await _usersApi.deleteUser(userUuid);
  }

  @override
  Future<User> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(UpdateUserParams params) async {
    final req = UpdateUserReq.fromParams(params);
    final dto = await _usersApi.updateUser(req);
    return dto.toEntity();
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
