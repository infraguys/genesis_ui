import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/shared/user.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._usersRepository) : super(InitUsersState()) {
    on(_getUsers);
  }

  final IUsersRepository _usersRepository;

  Future<void> _getUsers(_GetUsers event, Emitter<UsersState> emit) async {
    emit(LoadingUsersState());
    final users = await _usersRepository.getUsers();
    emit(SuccessUsersState(users));
  }
}
