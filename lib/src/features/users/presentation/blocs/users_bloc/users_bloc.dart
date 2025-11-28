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
  UsersBloc(
    GetUsersUseCase getUsersUseCase,
    DeleteUsersUseCase deleteUsersUseCase,
    ForceConfirmEmailsUseCase forceConfirmEmailsUseCase,
  ) : _getUsersUseCase = getUsersUseCase,
      _deleteUsersUseCase = deleteUsersUseCase,
      _forceConfirmEmailsUseCase = forceConfirmEmailsUseCase,
      super(_InitialState()) {
    on(_getUsers);
    on(_onDeleteUsers);
    on(_onForceConfirmEmails);
    add(UsersEvent.getUsers());
  }

  final GetUsersUseCase _getUsersUseCase;
  final DeleteUsersUseCase _deleteUsersUseCase;
  final ForceConfirmEmailsUseCase _forceConfirmEmailsUseCase;

  Future<void> _getUsers(_GetUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoadingState());
    final users = await _getUsersUseCase(GetUsersParams());
    emit(UsersLoadedState(users));
  }

  Future<void> _onDeleteUsers(_DeleteUsers event, Emitter<UsersState> emit) async {
    final previousState = state;

    final _DeleteUsers(:users) = event;

    try {
      // TODO(Вынести в usecase)
      await _deleteUsersUseCase(users);
      final newListOfUsers = List.of((state as UsersLoadedState).users)
        ..removeWhere((user) => users.contains(user));

      emit(UsersDeletedState(users));
      emit(UsersLoadedState(newListOfUsers));
    } on PermissionException catch (e) {
      emit(UsersPermissionFailureState(e.message));
      emit(previousState);
    }
  }

  Future<void> _onForceConfirmEmails(_ForceConfirmEmails event, Emitter<UsersState> emit) async {
    final _ForceConfirmEmails(:users) = event;
    emit(UsersLoadingState());
    await _forceConfirmEmailsUseCase(users);
    add(UsersEvent.getUsers());
  }
}
