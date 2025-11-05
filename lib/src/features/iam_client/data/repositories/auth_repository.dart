import 'package:genesis/src/core/exceptions/no_token_exception.dart';
import 'package:genesis/src/features/iam_client/data/requests/get_introspection_req.dart';
import 'package:genesis/src/features/iam_client/data/requests/token_req.dart';
import 'package:genesis/src/features/iam_client/domain/entities/auth_session.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/iam_client/sources/remote_iam_client_api.dart';
import 'package:genesis/src/features/iam_client/sources/token_dao.dart';
import 'package:genesis/src/features/permissions/permission_names/permission_names.dart';
import 'package:genesis/src/features/projects/data/requests/get_projects_req.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/users/data/dtos/user_dto.dart';

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
    await _tokenDao.writeToken(tokenDto.accessToken);
    await _tokenDao.writeRefreshToken(tokenDto.refreshToken);

    userDto = await _iamApi.getCurrentUser();

    if (userDto.username.toLowerCase() != 'admin') {
      final projectDtos = await _projectsApi.getProjects(GetProjectsReq());
      if (projectDtos.isNotEmpty) {
        final projectID = projectDtos.first.id;

        final paramsWithNewScope = params.copyWith(scope: 'project:$projectID');
        final tokenDto = await _iamApi.getToken(GetTokenReq(paramsWithNewScope));

        await _tokenDao.writeToken(tokenDto.accessToken);
        await _tokenDao.writeRefreshToken(tokenDto.refreshToken);
        userDto = await _iamApi.getCurrentUser();
      }
    }
    final clientIntrospectionDto = await _iamApi.introspectClient(GetIntrospectionReq());

    return AuthSession(
      user: userDto.toEntity(),
      permissionNames: PermissionNames(clientIntrospectionDto.permissions),
      refreshToken: tokenDto.refreshToken,
      scope: clientIntrospectionDto.projectId != null ? clientIntrospectionDto.projectId! : '',
    );
  }

  @override
  Future<AuthSession> forceRefreshToken(params) async {
    late UserDto userDto;

    final tokenDto = await _iamApi.getToken(RefreshTokenReq(params));

    await _tokenDao.writeToken(tokenDto.accessToken);
    await _tokenDao.writeRefreshToken(tokenDto.refreshToken);
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
    // await _tokenDao.deleteToken();
    final token = await _tokenDao.readToken();
    final refreshToken = await _tokenDao.readRefreshToken();
    if (token == null || token.isEmpty) {
      throw NoTokenException();
    }
    final userDto = await _iamApi.getCurrentUser();
    final clientIntrospectionDto = await _iamApi.introspectClient(GetIntrospectionReq());
    return AuthSession(
      user: userDto.toEntity(),
      permissionNames: PermissionNames(clientIntrospectionDto.permissions),
      refreshToken: refreshToken!,
      scope: clientIntrospectionDto.projectId != null ? clientIntrospectionDto.projectId! : '',
    );
  }

  @override
  Future<void> signOut() async {
    await _tokenDao.deleteToken();
    await _tokenDao.deleteRefreshToken();
  }
}
