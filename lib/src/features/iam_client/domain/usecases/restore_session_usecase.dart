import 'package:genesis/src/features/iam_client/domain/entities/auth_session.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';

final class RestoreSessionUseCase {
  RestoreSessionUseCase(this._repository);

  final IAuthRepository _repository;

  Future<AuthSession> call() async {
    return await _repository.restoreSession();
  }
}
