import 'dart:async';

import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/data/source/remote/i_users_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class UsersRepository implements IUsersRepository {
  UsersRepository(this._usersApi);

  final IUsersApi _usersApi;

  @override
  Future<List<User>> getUsers() async {
    final listOfUserDto = await _usersApi.getUsers();
    return listOfUserDto.map((it) => it.toEntity()).toList();
  }
}
