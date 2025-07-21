import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/domain/usecases/get_users_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._usersRepository) : super(UsersInitState()) {
    on(_getUsers);
  }

  final IUsersRepository _usersRepository;

  Future<void> _getUsers(_GetUsers event, Emitter<UsersState> emit) async {
    final useCase = GetUsersUseCase(_usersRepository);
    emit(UsersLoadingState());
    final users = await useCase();
    emit(UsersLoadedState(users));
  }
}
