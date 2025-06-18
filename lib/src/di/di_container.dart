import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/core/secure_storage_client/i_secure_storage_client.dart';
import 'package:genesis/src/core/secure_storage_client/secure_storage_client.dart';
import 'package:genesis/src/features/auth/data/iam_client_repository.dart';
import 'package:genesis/src/features/auth/data/source/impl/access_token_dao.dart';
import 'package:genesis/src/features/auth/data/source/impl/remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:provider/provider.dart';

class DiContainer extends StatelessWidget {
  const DiContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    print('di');
    return MultiProvider(
      providers: [
        Provider(
          create: (context) {
            return SecureStorageClient(FlutterSecureStorage());
          },
        ),
        RepositoryProvider(
          create: (context) {
            final iamApi = RemoteIamClientApi(RestClient());
            final storageClient = context.read<ISecureStorageClient>();
            final tokenDao = AccessTokenDao(storageClient);
            return IamClientRepository(
              iamApi: iamApi,
              accessTokenDao: tokenDao,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = context.read<IamClientRepository>();
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
