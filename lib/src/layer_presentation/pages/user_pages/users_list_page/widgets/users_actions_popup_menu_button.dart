import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_users_dialog.dart';
import 'package:genesis/src/theming/palette.dart';

class UsersActionsPopupMenuButton extends StatelessWidget {
  const UsersActionsPopupMenuButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return TooltipVisibility(
      visible: false,
      child: PopupMenuButton<_PopupBtnValue>(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
        icon: Icon(Icons.more_vert),
        useRootNavigator: true,
        onSelected: (value) {
          final users = List.generate(1, (_) => user);
          final child = switch (value) {
            // _PopupBtnValue.changePassword => ChangeUserPasswordDialog(),
            _PopupBtnValue.delete => DeleteUsersDialog.multiple(
              users: users,
              onDelete: () => context.read<UsersBloc>().add(UsersEvent.deleteUsers(users)),
            ),
          };
          showDialog<void>(
            context: context,
            builder: (_) {
              return child;
            },
          );
        },
        itemBuilder: (context) {
          return [
            // PopupMenuItem(
            //   value: _PopupBtnValue.changePassword,
            //   child: Text(context.$.changePassword),
            // ),
            PopupMenuItem(
              value: _PopupBtnValue.delete,
              child: Text(
                context.$.delete,
                style: TextStyle(color: Palette.colorF04C4C),
              ),
            ),
          ];
        },
      ),
    );
  }
}

enum _PopupBtnValue {
  // changePassword,
  delete,
}
