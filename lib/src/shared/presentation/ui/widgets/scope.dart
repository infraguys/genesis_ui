import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';

class Scope extends StatelessWidget {
  const Scope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, String?>(
      selector: (state) => state is AuthenticatedAuthState ? state.scope : null,
      builder: (context, selectedScope) {
        return KeyedSubtree(
          key: ValueKey(selectedScope),
          child: child,
        );
      },
    );
  }
}
