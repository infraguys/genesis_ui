import 'package:genesis/src/core/exceptions/no_token_exception.dart';
import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/requests/iam_client_requests/get_introspection_req.dart';
import 'package:genesis/src/layer_data/requests/iam_client_requests/token_req.dart';
import 'package:genesis/src/layer_data/requests/projects/get_projects_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_current_user_req.dart';
import 'package:genesis/src/layer_data/source/local/token_dao.dart';
import 'package:genesis/src/layer_data/source/remote/projects_api/projects_api.dart';
import 'package:genesis/src/layer_data/source/remote/remote_iam_client_api.dart';
import 'package:genesis/src/layer_domain/entities/auth_session.dart';
import 'package:genesis/src/layer_domain/iam/permission_names.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required RemoteIamClientApi iamApi,
    required TokenDao tokenDao,
    required ProjectsApi projectApi,
  }) : _iamApi = iamApi,
       _tokenDao = tokenDao,
       _projectsApi = projectApi;

  final RemoteIamClientApi _iamApi;
  final TokenDao _tokenDao;
  final ProjectsApi _projectsApi;

  @override
  Future<AuthSession> getToken(params) async {
    late UserDto userDto;

    final tokenDto = await _iamApi.getToken(GetTokenReq(params));
    await _tokenDao.writeAllTokens(accessToken: tokenDto.accessToken, refreshToken: tokenDto.refreshToken);

    userDto = await _iamApi.getCurrentUser(GetCurrentUserReq());

    if (userDto.username.toLowerCase() != 'admin') {
      final projectDtos = await _projectsApi.getProjects(GetProjectsReq());
      final projectUuid = projectDtos.first.uuid;

      final paramsWithNewScope = params.copyWith(scope: 'project:$projectUuid');
      final tokenDto = await _iamApi.getToken(GetTokenReq(paramsWithNewScope));
      await _tokenDao.writeAllTokens(accessToken: tokenDto.accessToken, refreshToken: tokenDto.refreshToken);

      userDto = await _iamApi.getCurrentUser(GetCurrentUserReq());
    }
    final clientIntrospectionDto = await _iamApi.introspectClient(GetIntrospectionReq());

    return AuthSession(
      user: userDto.toEntity(),
      permissionNames: PermissionNames(clientIntrospectionDto.permissions),
      refreshToken: tokenDto.refreshToken,
    );
  }

  @override
  Future<AuthSession> forceRefreshToken(params) async {
    late UserDto userDto;

    final tokenDto = await _iamApi.getToken(RefreshTokenReq(params));
    await _tokenDao.writeAllTokens(accessToken: tokenDto.accessToken, refreshToken: tokenDto.refreshToken);

    userDto = await _iamApi.getCurrentUser();
    final clientIntrospectionDto = await _iamApi.introspectClient(GetIntrospectionReq());

    return AuthSession(
      user: userDto.toEntity(),
      permissionNames: PermissionNames(clientIntrospectionDto.permissions),
      refreshToken: tokenDto.refreshToken,
      scope: clientIntrospectionDto.projectId != null ? clientIntrospectionDto.projectId! : '',
    );
  }

  @override
  Future<AuthSession> restoreSession() async {
    final token = await _tokenDao.readToken();
    final refreshToken = await _tokenDao.readRefreshToken();
    if (token == null || token.isEmpty) {
      throw NoTokenException();
    }
    final userDto = await _iamApi.getCurrentUser(GetCurrentUserReq());
    final clientIntrospectionDto = await _iamApi.introspectClient(GetIntrospectionReq());
    return AuthSession(
      user: userDto.toEntity(),
      permissionNames: PermissionNames(clientIntrospectionDto.permissions),
      refreshToken: refreshToken!,
        scope: clientIntrospectionDto.projectId != null ? clientIntrospectionDto.projectId! : ''
    );
  }

  @override
  Future<void> signOut() async {
    await _tokenDao.deleteToken();
    await _tokenDao.deleteRefreshToken();
  }
}
