import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/domain/entities/user.dart';
import 'package:go_router/go_router.dart';

class BlockUserDialog extends StatelessWidget {
  const BlockUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<User>();
    return AlertDialog(
      content: Text('Заблокировать ${user.username}?'.hardcoded),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(context.$.cancel),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            // todo: Implement block user logic
          },
          child: Text(context.$.ok),
        ),
      ],
    );
  }
}
