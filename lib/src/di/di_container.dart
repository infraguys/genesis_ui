import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/core/secure_storage_client/i_simple_storage_client.dart';
import 'package:genesis/src/core/secure_storage_client/shared_pref_storage.dart';
import 'package:genesis/src/features/auth/data/iam_client_repository.dart';
import 'package:genesis/src/features/auth/data/source/impl/remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/data/source/impl/remote_user_api.dart';
import 'package:genesis/src/features/auth/data/user_repository.dart';
import 'package:genesis/src/features/auth/domain/repositories/i_iam_client_repository.dart';
import 'package:genesis/src/features/auth/domain/repositories/i_user_repository.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
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
        Provider<RestClient>(
          create: (_) => RestClient(),
        ),
        RepositoryProvider<IIamClientRepository>(
          create: (context) {
            final iamApi = RemoteIamClientApi(context.read<RestClient>());
            return IamClientRepository(iamApi);
          },
        ),
        RepositoryProvider<IUserRepository>(
          create: (context) {
            final userApi = RemoteUserApi(context.read<RestClient>());
            return UserRepository(userApi);
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = context.read<IIamClientRepository>();
            return AuthBloc(repository);
          },
        ),
        Provider(
          create: (context) {
            return createRouter(context);
          },
        ),
      ],
      child: child,
    );
  }
}
