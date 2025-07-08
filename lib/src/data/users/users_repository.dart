import 'dart:async';

import 'package:genesis/src/data/users/source/remote/i_users_api.dart';
import 'package:genesis/src/data/users/source/requests/change_user_password_req.dart';
import 'package:genesis/src/data/users/source/requests/create_user_req.dart';
import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/domain/features/users/params/change_user_password_params.dart';
import 'package:genesis/src/domain/features/users/params/create_user_params.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository({
    required IUsersApi usersApi,
  }) : _usersApi = usersApi;

  final IUsersApi _usersApi;

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
  Future<List<User>> getUsers() async {
    final listOfUserDto = await _usersApi.getUsers();
    return listOfUserDto.map((it) => it.toEntity()).toList();
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

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
