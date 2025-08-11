import 'dart:async';

import 'package:genesis/src/layer_data/requests/users/change_user_password_req.dart';
import 'package:genesis/src/layer_data/requests/users/create_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_users_req.dart';
import 'package:genesis/src/layer_data/requests/users/update_user_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_users_api.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/change_user_password_params.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._usersApi);

  final IUsersApi _usersApi;

  @override
  Future<List<User>> getUsers(params) async {
    final req = GetUsersReq(params);
    final listOfUserDto = await _usersApi.getUsers(req);
    return listOfUserDto.map((it) => it.toEntity()).toList();
  }

  @override
  Future<User> changeUserPassword(ChangeUserPasswordParams params) async {
    final req = ChangeUserPasswordReq(params);
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
    final req = CreateUserReq(params);
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
    final req = UpdateUserReq(params);
    final dto = await _usersApi.updateUser(req);
    return dto.toEntity();
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
