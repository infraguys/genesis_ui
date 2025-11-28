import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/permissions/data/repositories/permissions_repository.dart';
import 'package:genesis/src/features/permissions/data/sources/permissions_api.dart';

final class PermissionsDiFactory {
  /// Repositories

  PermissionsRepository createPermissionsRepository(BuildContext context) {
    final permissionsApi = PermissionsApi(context.read<RestClient>());
    return PermissionsRepository(permissionsApi);
  }
}
