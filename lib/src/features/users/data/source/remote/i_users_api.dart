import 'package:genesis/src/features/users/data/dtos/users_feat_user_dto.dart';

abstract interface class IUsersApi {
  Future<List<UsersFeatUserDto>> getUsers();
}
