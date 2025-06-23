import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';
import 'package:genesis/src/features/auth/domain/use_case/i_user_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);

  final IUserRepository _repository;

  Future<User> call(SignUpParams params) async {
    return await _repository.createUser();
  }
}
