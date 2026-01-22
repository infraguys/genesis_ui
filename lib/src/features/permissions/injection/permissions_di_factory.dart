import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/permissions/data/repositories/permissions_repository.dart';
import 'package:genesis/src/features/permissions/data/sources/permissions_api.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/features/permissions/domain/usecases/get_permissions_usecases.dart';
import 'package:genesis/src/features/permissions/presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/features/permissions/presentation/blocs/permissions_selection_cubit/permissions_selection_cubit.dart';

final class PermissionsDiFactory {
  /// Repositories
  ///
  PermissionsRepository makePermissionsRepository(BuildContext context) {
    final permissionsApi = PermissionsApi(context.read<RestClient>());
    return PermissionsRepository(permissionsApi);
  }

  /// Blocs
  ///
  PermissionsBloc makePermissionsBloc(BuildContext context) {
    final repository = context.read<IPermissionsRepository>();
    return PermissionsBloc(getPermissionsUseCases: GetPermissionsUseCases(repository));
  }

  PermissionsSelectionCubit makePermissionsSelectionCubit(BuildContext context) {
    return PermissionsSelectionCubit();
  }
}
