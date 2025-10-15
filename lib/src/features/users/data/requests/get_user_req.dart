import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/get_user_params.dart';

extension GetUserParamsX on GetUserParams {
  String toPath() => UsersEndpoints.getUser(id);
}
