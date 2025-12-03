import 'package:flutter_test/flutter_test.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/get_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/domain/usecases/get_user_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_user_usecase_test.mocks.dart';

@GenerateMocks([IUsersRepository])
void main() {
  late MockIUsersRepository repository;
  late GetUserUseCase useCase;

  setUp(() {
    repository = MockIUsersRepository();
    useCase = GetUserUseCase(repository);
  });

  group('GetUserUseCase', () {
    test('возвращает пользователя из репозитория', () async {
      final userId = UserID('user-42');
      final params = GetUserParams(userId);
      final expectedUser = _buildUser(id: userId);

      when(repository.getUser(params)).thenAnswer((_) async => expectedUser);

      final result = await useCase(params);

      verify(repository.getUser(params)).called(1);
      verifyNoMoreInteractions(repository);

      expect(result, expectedUser);
    });


  });
}

User _buildUser({required UserID id}) {
  return User(
    uuid: id,
    username: 'username-$id',
    description: 'desc',
    createdAt: DateTime.utc(2024, 1, 1),
    updatedAt: DateTime.utc(2024, 1, 2),
    status: UserStatus.active,
    firstName: 'First',
    lastName: 'Last',
    surname: 'Surname',
    phone: '+123456789',
    email: 'user-$id@example.com',
    emailVerified: true,
    otpEnabled: false,
  );
}
