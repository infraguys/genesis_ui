import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/bloc_icon_button.dart';

class UsersBlockIconButton extends StatelessWidget {
  const UsersBlockIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersSelectionBloc, List<User>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return SizedBox.shrink();
        }
        return BlockIconButton(
          onPressed: () {},
        );
      },
    );
  }
}
