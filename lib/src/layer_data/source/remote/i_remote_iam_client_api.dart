import 'package:genesis/src/layer_data/dtos/client_introspection_dto.dart';
import 'package:genesis/src/layer_data/dtos/token_dto.dart';
import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/requests/iam_client_requests/get_introspection_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_current_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/sign_in_req.dart';

abstract interface class IRemoteIamClientApi {
  Future<TokenDto> createTokenByPassword(SignInReq req);

  Future<UserDto> getCurrentUser(GetCurrentUserReq req);

  Future<ClientIntrospectionDto> introspectClient(GetIntrospectionReq req);
}
