import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/params/users/change_user_password_params.dart';
import 'package:genesis/src/layer_domain/params/users/confirm_email_params.dart';
import 'package:genesis/src/layer_domain/params/users/delete_user_params.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/users/change_user_password_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/confirm_emails_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/delete_user_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/update_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserState.init()) {
    on(_onDeleteUser);
    on(_onChangeUserPassword);
    on(_onUpdateUser);
    on(_onConfirmEmail);
  }

  final IUsersRepository _repository;

  Future<void> _onDeleteUser(_DeleteUser event, Emitter<UserState> emit) async {
    final useCase = DeleteUserUseCase(_repository);
    emit(UserStateLoading());
    useCase(event.params);
    emit(UserState.success());
  }

  Future<void> _onChangeUserPassword(_ChangeUserPassword event, Emitter<UserState> emit) async {
    final useCase = ChangeUserPasswordUseCase(_repository);
    emit(UserStateLoading());
    useCase(event.params);
  }

  Future<void> _onUpdateUser(_UpdateUser event, Emitter<UserState> emit) async {
    final useCase = UpdateUserUseCase(_repository);
    emit(UserState.loading());
    await useCase(event.params);
    emit(UserState.success());
  }

  Future<void> _onConfirmEmail(_ConfirmEmails event, Emitter<UserState> emit) async {
    emit(UserState.loading());
    final useCase = ConfirmEmailsUseCase(_repository);
    await useCase(event.params.toList());
    emit(UserState.success());
  }
}
