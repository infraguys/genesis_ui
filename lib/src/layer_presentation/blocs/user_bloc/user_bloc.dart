import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/change_user_password_params.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/users/change_user_password_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/confirm_emails_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/create_user_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/delete_users_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/force_confirm_emails_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/get_user_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/users/update_user_usecase.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._repository) : super(UserInitialState()) {
    on(_onGetUser);
    on(_onCreateUser);
    on(_onDeleteUser);
    on(_onChangeUserPassword);
    on(_onUpdateUser);
    on(_onConfirmEmail);
    on(_onForceConfirmEmail);
  }

  final IUsersRepository _repository;

  Future<void> _onGetUser(_GetUser event, Emitter<UserState> emit) async {
    final useCase = GetUserUseCase(_repository);
    emit(UserLoadingState());
    try {
      final user = await useCase(event.uuid);
      emit(UserLoadedState(user));
    } on PermissionException catch (e) {
      emit(UserPermissionFailureState(e.message));
    } on ApiException catch (e) {
      emit(UserFailureState(e.message));
    }
  }

  Future<void> _onCreateUser(_CreateUser event, Emitter<UserState> emit) async {
    final useCase = CreateUserUseCase(_repository);
    emit(UserLoadingState());
    try {
      final createdUser = await useCase(event.params);
      emit(UserCreatedState(createdUser));
    } on PermissionException catch (e) {
      emit(UserPermissionFailureState(e.message));
    } on ApiException catch (e) {
      emit(UserFailureState(e.message));
    }
  }

  Future<void> _onDeleteUser(_DeleteUser event, Emitter<UserState> emit) async {
    final useCase = DeleteUserUseCase(_repository);
    try {
      await useCase(event.user);
      emit(UserDeletedState(event.user));
    } on PermissionException catch (e) {
      emit(UserPermissionFailureState(e.message));
    } on ApiException catch (e) {
      emit(UserFailureState(e.message));
    }
  }

  Future<void> _onChangeUserPassword(_ChangeUserPassword event, Emitter<UserState> emit) async {
    final useCase = ChangeUserPasswordUseCase(_repository);
    emit(UserLoadingState());
    useCase(event.params);
  }

  Future<void> _onUpdateUser(_UpdateUser event, Emitter<UserState> emit) async {
    final useCase = UpdateUserUseCase(_repository);
    try {
      final user = await useCase(event.params);
      emit(UserUpdatedState(user));
    } on PermissionException catch (e) {
      emit(UserPermissionFailureState(e.message));
    } on ApiException catch (e) {
      emit(UserFailureState(e.message));
    }
  }

  Future<void> _onConfirmEmail(_ConfirmEmails event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final useCase = ConfirmEmailsUseCase(_repository);
    await useCase(event.users);
    emit(UserConfirmedState());
  }

  Future<void> _onForceConfirmEmail(_ForceConfirmEmail event, Emitter<UserState> emit) async {
    final useCase = ForceConfirmEmailUseCase(_repository);
    try {
      final user = await useCase(event.user.uuid);
      emit(UserLoadedState(user));
    } on PermissionException catch (e) {
      emit(UserPermissionFailureState(e.message));
    } on ApiException catch (e) {
      emit(UserFailureState(e.message));
    }
  }
}
