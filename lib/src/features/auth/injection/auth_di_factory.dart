import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/iam_client/data/repositories/auth_repository.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/force_refresh_token_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/get_token_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/restore_session_usecase.dart';
import 'package:genesis/src/features/iam_client/domain/usecases/sign_out_usecase.dart';
import 'package:genesis/src/features/iam_client/sources/remote_iam_client_api.dart';
import 'package:genesis/src/features/iam_client/sources/token_dao.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/domain/usecases/create_user_usecase.dart';

final class AuthDiFactory {
  /// Repositories
  AuthRepository makeAuthRepository(BuildContext context) {
    var tokenDao = TokenDao(context.read<ISecureStorageClient>());
    if (kIsWeb) {
      final uri = Uri.base;

      final isHttp = uri.scheme == 'http';
      if (isHttp) {
        tokenDao = TokenDao(context.read<ISimpleStorageClient>());
      }
    }
    return AuthRepository(
      iamApi: RemoteIamClientApi(context.read<RestClient>()),
      projectApi: ProjectsApi(context.read<RestClient>()),
      tokenDao: tokenDao,
    );
  }

  /// Blocs

  AuthBloc makeAuthBloc(BuildContext context) {
    final authRepository = context.read<IAuthRepository>();
    final userRepository = context.read<IUsersRepository>();
    return AuthBloc(
      getTokenUseCase: GetTokenUseCase(authRepository),
      signOutUseCase: SignOutUseCase(authRepository),
      restoreSessionUseCase: RestoreSessionUseCase(authRepository),
      forceRefreshTokenUseCase: ForceRefreshTokenUseCase(authRepository),
      createUserUseCase: CreateUserUseCase(userRepository)
    );
  }
}
