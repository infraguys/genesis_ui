import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class DeleteUsersUseCase {
  DeleteUsersUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<void>> call(List<String> userUuids) async {
    return await Future.wait(
      userUuids.map((userUuid) => _repository.deleteUser(userUuid)),
    );
  }
}
