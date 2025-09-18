import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirm_email_icon_button.dart';

class ConfirmUserEmailElevatedButton extends StatelessWidget {
  const ConfirmUserEmailElevatedButton({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ConfirmEmailElevatedButton(
      onPressed: () {
        context.read<UserBloc>().add(UserEvent.forceConfirmEmail(user));
      },
    );
  }
}
