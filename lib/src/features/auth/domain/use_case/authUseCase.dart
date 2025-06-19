import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/i_iam_client_repository.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

class AuthUseCase {
  AuthUseCase(this._repository);

  final IIamClientRepository _repository;

  Future<IamClient?> call(CreateTokenParams params) async {
    return await _repository.fetchCurrentClient(params);
  }
}
