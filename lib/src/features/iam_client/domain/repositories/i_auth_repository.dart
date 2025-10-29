import 'package:genesis/src/features/iam_client/domain/entities/auth_session.dart';
import 'package:genesis/src/features/iam_client/domain/params/get_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/params/refresh_token_params.dart';

abstract interface class IAuthRepository {
  Future<AuthSession> getToken(GetTokenParams params);

  Future<AuthSession> forceRefreshToken(RefreshTokenParams params);

  Future<void> signOut();

  Future<AuthSession> restoreSession();
}
