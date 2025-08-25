import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/get_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class GetUserUseCase {
  GetUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(GetUserParams params) async {
    return await _repository.getUser(params);
  }
}
