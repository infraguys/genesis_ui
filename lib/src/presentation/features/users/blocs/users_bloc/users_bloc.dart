import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';
import 'package:genesis/src/domain/features/users/use_cases/delete_user_use_case.dart';
import 'package:genesis/src/domain/features/users/use_cases/get_users_use_case.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._usersRepository) : super(InitUsersState()) {
    on(_getUsers);
    on(_deleteUser);
    on(_blockUser);
  }

  final IUsersRepository _usersRepository;

  Future<void> _getUsers(_GetUsers event, Emitter<UsersState> emit) async {
    emit(LoadingUsersState());
    final useCase = GetUsersUseCase(_usersRepository);
    final users = await useCase();
    emit(SuccessUsersState(users));
  }

  Future<void> _deleteUser(_DeleteUser event, Emitter<UsersState> emit) async {
    final deleteUseCase = DeleteUserUseCase(_usersRepository);
    emit(LoadingUsersState());
    await deleteUseCase(event.userUuid);
    add(UsersEvent.getUsers());
  }

  Future<void> _blockUser(_BlockUser event, Emitter<UsersState> emit) async {}
}
