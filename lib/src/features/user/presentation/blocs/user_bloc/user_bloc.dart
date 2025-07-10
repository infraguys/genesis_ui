import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/user/domain/i_user_repository.dart';
import 'package:genesis/src/features/user/domain/params/change_user_password_params.dart';
import 'package:genesis/src/features/user/domain/params/update_user_params.dart';
import 'package:genesis/src/features/user/domain/usecases/change_user_password_usecase.dart';
import 'package:genesis/src/features/user/domain/usecases/delete_user_usecase.dart';
import 'package:genesis/src/features/user/domain/usecases/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserState.init()) {
    on(_deleteUser);
    on(_changeUserPassword);
    on(_updateUser);
  }

  final IUserRepository _repository;

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

  Future<void> _updateUser(_UpdateUser event, Emitter<UserState> emit) async {
    final updateUseCase = UpdateUserUseCase(_repository);
    final params = UpdateUserParams(
      uuid: event.uuid,
      username: event.username,
      description: event.description,
      firstName: event.firstName,
      lastName: event.lastName,
      surname: event.surname,
      phone: event.phone,
      email: event.email,
    );
    emit(UserState.loading());
    await updateUseCase(params);
    emit(UserState.updateSuccess());
  }
}
