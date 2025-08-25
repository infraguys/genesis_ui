import 'dart:async';

import 'package:genesis/src/layer_data/requests/users/change_user_password_req.dart';
import 'package:genesis/src/layer_data/requests/users/confirm_email_req.dart';
import 'package:genesis/src/layer_data/requests/users/create_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/delete_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_users_req.dart';
import 'package:genesis/src/layer_data/requests/users/update_user_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_users_api.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/change_user_password_params.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._usersApi);

  final IUsersApi _usersApi;

  @override
  Future<List<User>> getUsers(params) async {
    final listOfUserDto = await _usersApi.getUsers(GetUsersReq(params));
    return listOfUserDto.map((it) => it.toEntity()).toList();
  }

  @override
  Future<User> changeUserPassword(ChangeUserPasswordParams params) async {
    final dto = await _usersApi.changeUserPassword(ChangeUserPasswordReq(params));
    return dto.toEntity();
  }

  @override
  Future<User> confirmEmail(params) async {
    final dto = await _usersApi.confirmEmail(ConfirmEmailReq(params));
    return dto.toEntity();
  }

  @override
  Future<User> createUser(CreateUserParams params) async {
    final dto = await _usersApi.createUser(CreateUserReq(params));
    return dto.toEntity();
  }

  @override
  Future<void> deleteUser(params) async {
    await _usersApi.deleteUser(DeleteUserReq(params));
  }

  @override
  Future<User> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(params) async {
    final dto = await _usersApi.updateUser(UpdateUserReq(params));
    return dto.toEntity();
  }

  @override
  Future<User> getUser(params) async {
    final dto = await _usersApi.getUser(GetUserReq(params));
    return dto.toEntity();
  }
}
