import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/get_users_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/domain/usecases/delete_users_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/force_confirm_emails_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/get_users_usecase.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._usersRepository) : super(_InitialState()) {
    on(_getUsers);
    on(_onDeleteUsers);
    on(_onForceConfirmEmails);
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
    final previousState = state;

    try {
      await useCase(event.users);
      final newListOfUsers = List.of((state as UsersLoadedState).users)
        ..removeWhere((user) => event.users.contains(user));

      emit(UsersDeletedState(event.users));
      emit(UsersLoadedState(newListOfUsers));
    } on PermissionException catch (e) {
      emit(UsersPermissionFailureState(e.message));
      emit(previousState);
    }
  }

  Future<void> _onForceConfirmEmails(_ForceConfirmEmails event, Emitter<UsersState> emit) async {
    final useCase = ForceConfirmEmailsUseCase(_usersRepository);
    final uuids = event.users.where((user) => !user.emailVerified).map((user) => user.uuid);
    emit(UsersLoadingState());
    await useCase(uuids.toList());
    add(UsersEvent.getUsers());
  }
}
