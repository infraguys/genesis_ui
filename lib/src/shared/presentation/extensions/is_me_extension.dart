import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';

extension IsMeExt on BuildContext {
  bool isMe(UserUUID uuid) {
    final authenticatedState = (read<AuthBloc>().state as AuthenticatedAuthState);
    return authenticatedState.isEqualUuid(uuid);
  }
}
