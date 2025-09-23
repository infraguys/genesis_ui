import 'package:genesis/src/core/exceptions/no_token_exception.dart';
import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/requests/projects/get_projects_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_current_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/sign_in_req.dart';
import 'package:genesis/src/layer_data/source/local/token_dao.dart';
import 'package:genesis/src/layer_data/source/remote/i_remote_iam_client_api.dart';
import 'package:genesis/src/layer_data/source/remote/projects_api/i_projects_api.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required IRemoteIamClientApi iamApi,
    required TokenDao tokenDao,
    required IProjectsApi projectApi,
  }) : _iamApi = iamApi,
       _tokenDao = tokenDao,
       _projectsApi = projectApi;

  final IRemoteIamClientApi _iamApi;
  final TokenDao _tokenDao;
  final IProjectsApi _projectsApi;

  @override
  Future<User> signIn(params) async {
    late UserDto userDto;

    final tokenDto = await _iamApi.createTokenByPassword(SignInReq(params));
    await _tokenDao.writeToken(tokenDto.accessToken);
    await _tokenDao.writeRefreshToken(tokenDto.refreshToken);
    userDto = await _iamApi.getCurrentUser(GetCurrentUserReq());

    if (userDto.username.toLowerCase() != 'admin') {
      final projectDtos = await _projectsApi.getProjects(GetProjectsReq());
      final projectUuid = projectDtos.first.uuid;

      final paramsWithNewScope = params.copyWith(scope: 'project:$projectUuid');
      final tokenDto = await _iamApi.createTokenByPassword(SignInReq(paramsWithNewScope));
      await _tokenDao.writeToken(tokenDto.accessToken);
      await _tokenDao.writeRefreshToken(tokenDto.refreshToken);
      userDto = await _iamApi.getCurrentUser(GetCurrentUserReq());
    }

    return userDto.toEntity();
  }

  @override
  Future<User> restoreSession() async {
    final token = await _tokenDao.readToken();
    if (token == null || token.isEmpty) {
      throw NoTokenException();
    }
    final userDto = await _iamApi.getCurrentUser(GetCurrentUserReq());
    return userDto.toEntity();
  }

  @override
  Future<void> signOut() async {
    await _tokenDao.deleteToken();
    await _tokenDao.deleteRefreshToken();
  }
}
