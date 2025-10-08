import 'package:genesis/src/layer_domain/entities/auth_session.dart';
import 'package:genesis/src/layer_domain/params/users/refresh_token_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';

class ForceRefreshTokenUseCase {
  ForceRefreshTokenUseCase(this._repo);

  final IAuthRepository _repo;

  Future<AuthSession> call(RefreshTokenParams params) async {
    return await _repo.forceRefreshToken(params);
  }
}
