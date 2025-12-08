import 'package:flutter_test/flutter_test.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/delete_user_params.dart';
import 'package:genesis/src/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/users_mocks.mocks.dart';

void main() {
  late MockIUsersRepository repository;
  late DeleteUserUseCase useCase;

  setUp(() {
    repository = MockIUsersRepository();
    useCase = DeleteUserUseCase(repository);
  });

  group('DeleteUserUseCase', () {
    test('Успешно вызывает deleteUser у репозитория', () async {
      final id = UserID('user-123');
      final params = DeleteUserParams(id);

      when(repository.deleteUser(params)).thenAnswer((_) async {});

      await useCase(params);

      verify(repository.deleteUser(params)).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
