import 'dart:async';

import 'package:genesis/src/features/users/data/sources/users_api.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._usersApi);

  final UsersApi _usersApi;

  @override
  Future<List<User>> getUsers(params) async {
    final listOfUserDto = await _usersApi.getUsers(params);
    return listOfUserDto.map((it) => it.toEntity()).toList();
  }

  @override
  Future<User> changeUserPassword(params) async {
    final dto = await _usersApi.changeUserPassword(params);
    return dto.toEntity();
  }

  @override
  Future<User> confirmEmail(params) async {
    final dto = await _usersApi.confirmEmail(params);
    return dto.toEntity();
  }

  @override
  Future<User> forceConfirmEmail(params) async {
    final dto = await _usersApi.forceConfirmEmail(params);
    return dto.toEntity();
  }

  @override
  Future<User> createUser(params) async {
    final dto = await _usersApi.createUser(params);
    return dto.toEntity();
  }

  @override
  Future<void> deleteUser(params) async {
    await _usersApi.deleteUser(params);
  }

  @override
  Future<User> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(params) async {
    final dto = await _usersApi.updateUser(params);
    return dto.toEntity();
  }

  @override
  Future<User> getUser(params) async {
    final dto = await _usersApi.getUser(params);
    return dto.toEntity();
  }
}
