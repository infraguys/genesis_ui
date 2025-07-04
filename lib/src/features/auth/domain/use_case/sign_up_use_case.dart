import 'package:genesis/src/features/auth/domain/i_auth_repository.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';
import 'package:genesis/src/features/shared/user.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);

  final IAuthRepository _repository;

  Future<User> call(SignUpParams params) async {
    return await _repository.singUp(params);
  }
}
