import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/confirm_email_params.dart';
import 'package:genesis/src/layer_domain/params/users/delete_user_params.dart';
import 'package:genesis/src/layer_domain/params/users/get_users_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/users/delete_users_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/force_confirm_emails_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/get_users_usecase.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._usersRepository) : super(UsersState.initial()) {
    on(_getUsers);
    on(_onDeleteUsers);
    on(_onForceConfirmEmails);
    add(UsersEvent.getUsers());
  }

  final IUsersRepository _usersRepository;

  Future<void> _getUsers(_GetUsers event, Emitter<UsersState> emit) async {
    final useCase = GetUsersUseCase(_usersRepository);
    emit(UsersState.loading());
    final users = await useCase(GetUsersParams());
    emit(UsersState.loaded(users));
  }

  Future<void> _onDeleteUsers(_DeleteUsers event, Emitter<UsersState> emit) async {
    final useCase = DeleteUsersUseCase(_usersRepository);
    final listOfParams = event.users.map((user) => DeleteUserParams(user.uuid));
    emit(UsersState.loading());
    await useCase(listOfParams.toList());
    add(UsersEvent.getUsers());
  }

  Future<void> _onForceConfirmEmails(_ForceConfirmEmails event, Emitter<UsersState> emit) async {
    final useCase = ForceConfirmEmailsUseCase(_usersRepository);
    final listOfParams = event.users
        .where((user) => !user.emailVerified)
        .map((user) => ConfirmEmailParams(uuid: user.uuid));
    emit(UsersState.loading());
    await useCase(listOfParams.toList());
    add(UsersEvent.getUsers());
  }
}
