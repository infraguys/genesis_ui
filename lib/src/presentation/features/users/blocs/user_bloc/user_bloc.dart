import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/domain/features/users/params/create_user_params.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';
import 'package:genesis/src/domain/features/users/use_cases/create_user.dart';
import 'package:genesis/src/domain/features/users/use_cases/delete_user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserState.init()) {
    on<_CreateUser>(_signUp);
    on(_deleteUser);
  }

  final IUsersRepository _repository;

  Future<void> _signUp(_CreateUser event, Emitter<UserState> emit) async {
    final useCase = CreateUserUseCase(_repository);
    emit(UserState.loading());
    try {
      final createdUser = await useCase(
        CreateUserParams(
          username: event.username,
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
        ),
      );
      emit(UserState.userCreated());
    } on NetworkException catch (e) {
      emit(UserState.createdFailure(e.message));
    }
  }

  Future<void> _deleteUser(_DeleteUser event, Emitter<UserState> emit) async {
    final deleteUseCase = DeleteUserUseCase(_repository);
    emit(LoadingUserState());
    deleteUseCase(event.userUuid);
    emit(UserState.deleteSuccess());
  }
}
