import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/domain/usecases/create_user_usecase.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc(this._repository) : super(CreateUserStateInit()) {
    on(_createUser);
  }

  final IUsersRepository _repository;

  Future<void> _createUser(_CreateUser event, Emitter<CreateUserState> emit) async {
    final useCase = CreateUserUseCase(_repository);
    emit(CreateUserStateLoading());
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
      emit(CreateUserStateCreated(createdUser));
    } on NetworkException catch (e) {
      emit(CreateUserStateFailure(e.message));
    }
  }
}
