import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class MeAppbarWidget extends StatelessWidget {
  const MeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;

    final user = authState.user;
    // final firstLetter = user.username.substring(0, 1).toUpperCase();
    // final secondLetter = user.username.substring(0, 1).toUpperCase();
    return TooltipVisibility(
      visible: false,
      child: MenuAnchor(
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
      ),
      // child: PopupMenuButton<_MenuOptions>(
      //   clipBehavior: Clip.antiAlias,
      //   constraints: BoxConstraints(maxWidth: 140, minWidth: 140),
      //   position: PopupMenuPosition.under,
      //   padding: EdgeInsets.only(left: 4, right: 16),
      //
      //   onSelected: (value) {
      //     switch (value) {
      //       case _MenuOptions.signOut:
      //         WidgetsBinding.instance.addPostFrameCallback((_) {
      //           if (!context.mounted) return;
      //           context.read<AuthBloc>().add(AuthEvent.signOut());
      //         });
      //         // context.read<AuthBloc>().add(AuthEvent.signOut());
      //     }
      //   },
      //   // offset: Offset(0, 30),
      //   icon: Row(
      //     spacing: 10,
      //     children: [
      //       Icon(Icons.account_circle, color: Palette.colorAFA8A4, size: 28),
      //       // todo: вынести в стили
      //       Text(
      //         user.username,
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     ],
      //   ),
      //   itemBuilder: (context) {
      //     return [
      //       PopupMenuItem(
      //         onTap: () {
      //
      //         },
      //         value: _MenuOptions.signOut,
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Icon(Icons.logout, color: Palette.colorF04C4C),
      //               Text(context.$.signOut, style: TextStyle(color: Palette.colorF04C4C)),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ];
      //   },
      // ),
    );
  }
}
