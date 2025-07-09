import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/domain/features/users/params/change_user_password_params.dart';
import 'package:genesis/src/domain/features/users/params/create_user_params.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';
import 'package:genesis/src/domain/features/users/use_cases/change_user_password_usecase.dart';
import 'package:genesis/src/domain/features/users/use_cases/create_user_usecase.dart';
import 'package:genesis/src/domain/features/users/use_cases/delete_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserState.init()) {
    on(_deleteUser);
    on(_changeUserPassword);
  }

  final IUsersRepository _repository;

  Future<void> _deleteUser(_DeleteUser event, Emitter<UserState> emit) async {
    final deleteUseCase = DeleteUserUseCase(_repository);
    emit(UserStateLoading());
    deleteUseCase(event.userUuid);
    emit(UserState.deleteSuccess());
  }

  Future<void> _changeUserPassword(_ChangeUserPassword event, Emitter<UserState> emit) async {
    final changePasswordUseCase = ChangeUserPasswordUseCase(_repository);
    emit(UserStateLoading());
    changePasswordUseCase(
      ChangeUserPasswordParams(
        uuid: event.uuid,
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ),
    );
  }
}
