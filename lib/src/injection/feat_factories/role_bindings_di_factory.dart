import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/roles/data/repositories/role_bindings_repository.dart';
import 'package:genesis/src/features/roles/data/sources/role_bindings_api.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';

final class RoleBindingsDiFactory {
  /// Repositories

  RoleBindingsRepository createRoleBindingsRepository(BuildContext context) {
    final roleBindingsApi = RoleBindingsApi(context.read<RestClient>());
    return RoleBindingsRepository(roleBindingsApi);
  }

  /// Blocs

  RoleBindingsBloc createRoleBindingsBloc(BuildContext context) {
    return RoleBindingsBloc(context.read<IRoleBindingsRepository>());
  }
}
