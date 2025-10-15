import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class MeAppbarWidget extends StatelessWidget {
  const MeAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is! AuthenticatedAuthState) {
          return SizedBox.shrink();
        }
        final user = authState.user;
        final firstLetter = user.firstName.substring(0, 1).toUpperCase();
        final secondLetter = user.lastName.substring(0, 1).toUpperCase();
        return TooltipVisibility(
          visible: false,
          child: PopupMenuButton<void>(
            clipBehavior: Clip.antiAlias,
            constraints: BoxConstraints(maxWidth: 140, minWidth: 140),
            position: PopupMenuPosition.under,
            padding: EdgeInsets.only(left: 4, right: 16),
            // offset: Offset(0, 30),
            icon: Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 16,
                  child: Text(
                    '$firstLetter$secondLetter',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                // todo: вынести в стили
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.logout, color: Palette.colorF04C4C),
                        Text('Sign out', style: TextStyle(color: Palette.colorF04C4C)),
                      ],
                    ),
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(AuthEvent.signOut());
                  },
                ),
              ];
            },
          ),
        );
      },
    );
  }
}
