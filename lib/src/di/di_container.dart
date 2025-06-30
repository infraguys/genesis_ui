import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/core/storage_clients/secure_storage_client.dart';
import 'package:genesis/src/core/storage_clients/shared_pref_storage.dart';
import 'package:genesis/src/features/auth/data/auth_repository.dart';
import 'package:genesis/src/features/auth/data/source/local/token_dao.dart';
import 'package:genesis/src/features/auth/data/source/remote/remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/data/source/remote/remote_me_api.dart';
import 'package:genesis/src/features/auth/domain/i_auth_repository.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:provider/provider.dart';

class DiContainer extends StatelessWidget {
  const DiContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ISimpleStorageClient>(
          create: (_) => SharedPrefStorage(),
        ),
        Provider<SecureStorageClient>(
          create: (_) => FlutterSecureStorageClient(),
        ),
        Provider<RestClient>(
          create: (context) {
            final secureStorage = context.read<SecureStorageClient>();
            return RestClient(secureStorage);
          },
        ),
        RepositoryProvider<IAuthRepository>(
          create: (context) {
            final tokenDao = TokenDao(context.read<SecureStorageClient>());
            final iamApi = RemoteIamClientApi(context.read<RestClient>());
            final meApi = RemoteMeApi(context.read<RestClient>());
            return AuthRepository(iamApi: iamApi, meApi: meApi, tokenDao: tokenDao);
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = context.read<IAuthRepository>();
            return AuthBloc(repository);
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = context.read<IAuthRepository>();
            return UserBloc(repository);
          },
        ),
        Provider(
          create: (context) => createRouter(context),
        ),
      ],
      child: child,
    );
  }
}
