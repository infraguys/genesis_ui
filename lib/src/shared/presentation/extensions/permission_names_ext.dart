import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/permissions/permission_names/permission_names.dart';

extension PermissionNamesExt on BuildContext {
  PermissionNames get permissionNames {
    final state = read<AuthBloc>().state as AuthenticatedAuthState;
    return state.permissionNames;
  }
}
