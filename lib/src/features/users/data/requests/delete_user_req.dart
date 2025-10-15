import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/delete_user_params.dart';

extension DeleteUserParamsX on DeleteUserParams {
  String toPath() => UsersEndpoints.deleteUser(id);
}
