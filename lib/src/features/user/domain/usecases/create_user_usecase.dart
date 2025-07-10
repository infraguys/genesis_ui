import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/user/domain/i_user_repository.dart';
import 'package:genesis/src/features/user/domain/params/create_user_params.dart';

final class CreateUserUseCase {
  CreateUserUseCase(this._repository);

  final IUserRepository _repository;

  Future<User> call(CreateUserParams params) async {
    return await _repository.createUser(params);
  }
}
