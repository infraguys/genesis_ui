import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/users/data/repositories/users_repository.dart';
import 'package:genesis/src/features/users/data/sources/users_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/domain/usecases/change_user_password_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/confirm_emails_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/create_user_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/delete_users_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/force_confirm_email_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/force_confirm_emails_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/get_user_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/get_users_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/reset_password_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/update_user_usecase.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_selection_cubit/users_selection_cubit.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';

final class UsersDiFactory {
  IUsersRepository createUsersRepository(BuildContext context) {
    final usersApi = UsersApi(context.read<RestClient>());
    return UsersRepository(usersApi);
  }

  /// Blocs

  UsersBloc createUsersBloc(BuildContext context) {
    final usersRepo = context.read<IUsersRepository>();
    return UsersBloc(
      GetUsersUseCase(usersRepo),
      DeleteUsersUseCase(usersRepo),
      ForceConfirmEmailsUseCase(usersRepo),
    );
  }

  UserBloc createUserBloc(BuildContext context) {
    final repository = context.read<IUsersRepository>();
    return UserBloc(
      getUserUseCase: GetUserUseCase(repository),
      createUserUseCase: CreateUserUseCase(repository),
      deleteUserUseCase: DeleteUserUseCase(repository),
      changeUserPasswordUseCase: ChangeUserPasswordUseCase(repository),
      updateUserUseCase: UpdateUserUseCase(repository),
      confirmEmailsUseCase: ConfirmEmailsUseCase(repository),
      forceConfirmEmailUseCase: ForceConfirmEmailUseCase(repository),
      resetPasswordUsecase: ResetPasswordUsecase(repository)
    );
  }

  UsersSelectionCubit createUserSelectionCubit() {
    return UsersSelectionCubit();
  }
}
