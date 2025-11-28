import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/permissions/data/repositories/permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/data/sources/permission_binding_api.dart';

final class PermissionBindingsDiFactory {
  /// Repositories

  PermissionBindingsRepository createPermissionBindingsRepository(BuildContext context) {
    final permissionBindingsApi = PermissionBindingsApi(context.read<RestClient>());
    return PermissionBindingsRepository(permissionBindingsApi);
  }
}
