import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/iam_client/data/repositories/auth_repository.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/iam_client/sources/remote_iam_client_api.dart';
import 'package:genesis/src/features/iam_client/sources/token_dao.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

final class AuthDiFactory {
  /// Repositories
  AuthRepository createAuthRepository(BuildContext context) {
    var tokenDao = TokenDao(context.read<ISecureStorageClient>());
    if (kIsWeb) {
      final uri = Uri.base;

      final isHttp = uri.scheme == 'http';
      if (isHttp) {
        tokenDao = TokenDao(context.read<ISimpleStorageClient>());
      }
    }
    final iamApi = RemoteIamClientApi(context.read<RestClient>());
    final projectsApi = ProjectsApi(context.read<RestClient>());
    return AuthRepository(
      iamApi: iamApi,
      tokenDao: tokenDao,
      projectApi: projectsApi,
    );
  }

  /// Blocs

  AuthBloc createAuthBloc(BuildContext context) {
    return AuthBloc(
      context.read<IAuthRepository>(),
      context.read<IUsersRepository>(),
    );
  }
}
