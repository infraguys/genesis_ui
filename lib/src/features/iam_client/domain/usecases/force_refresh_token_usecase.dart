import 'package:genesis/src/features/iam_client/domain/entities/auth_session.dart';
import 'package:genesis/src/features/iam_client/domain/params/refresh_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';

class ForceRefreshTokenUseCase {
  ForceRefreshTokenUseCase(this._repo);

  final IAuthRepository _repo;

  Future<AuthSession> call(RefreshTokenParams params) async {
    return await _repo.forceRefreshToken(params);
  }
}
