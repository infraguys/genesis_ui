import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/change_user_password_dialog.dart';
import 'package:provider/provider.dart';

class UsersActionsPopupMenuButton extends StatelessWidget {
  const UsersActionsPopupMenuButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_PopupBtnValue>(
      icon: Icon(Icons.more_vert),
      onSelected: (value) {
        final child = switch (value) {
          _PopupBtnValue.changePassword => ChangeUserPasswordDialog(),
        };
        showDialog<void>(
          context: context,
          builder: (_) {
            return Provider.value(
              value: context.read<User>(),
              child: child,
            );
          },
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      useRootNavigator: true,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: _PopupBtnValue.changePassword,
            child: Text(context.$.changePassword),
          ),
          PopupMenuItem(
            child: Text(context.$.changeEmail),
          ),
        ];
      },
    );
  }
}

enum _PopupBtnValue {
  changePassword,
}
