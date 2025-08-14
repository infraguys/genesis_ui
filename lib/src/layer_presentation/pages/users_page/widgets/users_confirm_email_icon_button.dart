import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/confirm_email_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirm_email_icon_button.dart';

class UsersConfirmEmailIconButton extends StatelessWidget {
  const UsersConfirmEmailIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersSelectionBloc, List<User>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return ConfirmEmailIconButton(
          onPressed: () {
            context.read<UserBloc>().add(
              UserEvent.confirmEmail(
                state.map((it) => ConfirmEmailParams(uuid: it.uuid)).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
