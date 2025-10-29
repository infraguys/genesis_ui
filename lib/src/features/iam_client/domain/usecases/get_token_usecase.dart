import 'package:genesis/src/features/iam_client/domain/entities/auth_session.dart';
import 'package:genesis/src/features/iam_client/domain/params/get_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';

class GetTokenUseCase {
  GetTokenUseCase(this._repo);

  final IAuthRepository _repo;

  Future<AuthSession> call(GetTokenParams params) async {
    return await _repo.getToken(params);
  }
}
