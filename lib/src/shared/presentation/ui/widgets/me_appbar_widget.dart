import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class MeAppbarWidget extends StatelessWidget {
  const MeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final firstLetter = user.username.substring(0, 1).toUpperCase();
    // final secondLetter = user.username.substring(0, 1).toUpperCase();
    return TooltipVisibility(
      visible: false,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! AuthenticatedAuthState) {
            return SizedBox.shrink();
          }
          final user = state.user;
          return MenuAnchor(
            builder: (context, controller, _) {
              return TextButton.icon(
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(TextStyle(height: 1.2)),
                  padding: WidgetStatePropertyAll(.only(left: 8, right: 8)),
                  iconSize: WidgetStatePropertyAll(25),
                ),
                label: Text(user.username),
                icon: Icon(Icons.account_circle),
                onPressed: () => controller.isOpen ? controller.close() : controller.open(),
              );
            },
            menuChildren: [
              MenuItemButton(
                leadingIcon: Icon(Icons.logout, color: Colors.red),
                child: Text(context.$.signOut),
                onPressed: () => context.read<AuthBloc>().add(AuthEvent.signOut()),
              ),
            ],
          );
        },
      ),
    );
  }
}
