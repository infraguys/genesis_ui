import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/get_users_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/users/delete_users_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/get_users_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._usersRepository) : super(UsersInitState()) {
    on(_getUsers);
    on(_onDeleteUsers);
    add(UsersEvent.getUsers());
  }

  final IUsersRepository _usersRepository;

  Future<void> _getUsers(_GetUsers event, Emitter<UsersState> emit) async {
    final useCase = GetUsersUseCase(_usersRepository);
    emit(UsersLoadingState());
    final users = await useCase(GetUsersParams());
    emit(UsersLoadedState(users));
  }

  Future<void> _onDeleteUsers(_DeleteUsers event, Emitter<UsersState> emit) async {
    final useCase = DeleteUsersUseCase(_usersRepository);
    emit(UsersLoadingState());
    await useCase(event.userUuids);
    add(UsersEvent.getUsers());
  }
}
