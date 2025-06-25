import 'package:genesis/src/features/auth/data/dtos/user_dto.dart';
import 'package:genesis/src/features/auth/data/requests/sign_up_req.dart';

abstract interface class IRemoteMeApi {
  Future<UserDto> signUp(SignUpReq req);

  // Future<UserDto> getUser();
  //
  // Future<UserDto> updateUser();
  //
  // Future<UserDto> deleteUser();
  //
  // Future<UserDto> changeUserPassword();
  //
  // Future<UserDto> resetUserPassword();
  //
  // Future<UserDto> confirmUserEmail();
  //
  // Future<List<UserDto>> getUsers();
}
