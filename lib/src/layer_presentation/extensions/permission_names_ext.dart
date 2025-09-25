import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/iam/permission_names.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';

extension PermissionNamesExt on BuildContext {
  PermissionNames get permissionNames {
    final state = read<AuthBloc>().state as AuthenticatedAuthState;
    return state.permissionNames;
  }
}
