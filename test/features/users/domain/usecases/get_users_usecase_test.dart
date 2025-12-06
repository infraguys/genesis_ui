import 'package:flutter_test/flutter_test.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/get_user_params.dart';
import 'package:genesis/src/features/users/domain/params/get_users_params.dart';
import 'package:genesis/src/features/users/domain/usecases/get_user_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/get_users_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/users_mocks.mocks.dart';

void main() {
  late MockIUsersRepository repository;
  late GetUsersUseCase useCase;

  setUp(() {
    repository = MockIUsersRepository();
    useCase = GetUsersUseCase(repository);
  });

  group('GetUsersUseCase', () {
    test('Возвращает список пользователей', () async {
      final params = GetUsersParams();
      final expectedUsers = _buildUsers();

      when(repository.getUsers(params)).thenAnswer((_) async => expectedUsers);
      final result = await useCase(params);

      verify(repository.getUsers(params)).called(1);
      verifyNoMoreInteractions(repository);

      expect(result, expectedUsers);
      expect(result, hasLength(2));
      expect(result[0].username, 'username-1');
      expect(result[1].username, 'username-2');
    });
    test('Возвращает пустой список пользователей если данные отсутствуют', () async {
      final params = GetUsersParams();
      final expectedUsers = <User>[];

      when(repository.getUsers(params)).thenAnswer((_) async => expectedUsers);
      final result = await useCase(params);

      verify(repository.getUsers(params)).called(1);
      verifyNoMoreInteractions(repository);

      expect(result, expectedUsers);
      expect(result, isEmpty);
    });
  });
}

List<User> _buildUsers() {
  return [
    User(
      uuid: UserID('user-1'),
      username: 'username-1',
      description: 'desc',
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 2),
      status: UserStatus.active,
      firstName: 'First',
      lastName: 'First-lastname',
      surname: 'First-surname',
      phone: '+123456789',
      email: 'user-1@example.com',
      emailVerified: true,
      otpEnabled: false,
    ),
    User(
      uuid: UserID('user-2'),
      username: 'username-2',
      description: 'desc',
      createdAt: DateTime.utc(2024, 1, 1),
      updatedAt: DateTime.utc(2024, 1, 2),
      status: UserStatus.active,
      firstName: 'Second',
      lastName: 'Second-lastname',
      surname: 'Second-surname',
      phone: '+123456789',
      email: 'user-2@example.com',
      emailVerified: false,
      otpEnabled: true,
    ),
  ];
}
