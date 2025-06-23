import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/i_iam_client_repository.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

class SignInUseCase {
  SignInUseCase(this._repo);

  final IIamClientRepository _repo;

  Future<IamClient?> call(CreateTokenParams params) async {
    return await _repo.getCurrentClient(params);
  }
}
