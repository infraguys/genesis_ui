import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/data/iam_client_repository.dart';
import 'package:genesis/src/features/auth/data/source/impl/remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/presentation/auth_bloc/auth_bloc/auth_bloc/auth_bloc.dart';

class DiContainer extends StatelessWidget {
  const DiContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) {
            final iamApi = RemoteIamClientApi(RestClient());
            return IamClientRepository(iamApi);
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = context.read<IamClientRepository>();
            return AuthBloc(repository);
          },
        ),
      ],
      child: child,
    );
  }
}
