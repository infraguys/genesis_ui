import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/widgets/users_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/theming/palette.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserStateDeleteSuccess():
          case UserStateUpdateSuccess():
            context.read<UsersBloc>().add(UsersEvent.getUsers());
          default:
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO: Добавить название страницы
          Breadcrumbs(
            items: [
              BreadcrumbItem(text: context.$.users),
            ],
          ),
          // Text(context.$.users, ),
          const SizedBox(height: 24),
          Row(
            spacing: 4.0,
            children: [
              Spacer(),
              BlocBuilder<UsersSelectionBloc, List<User>>(
                builder: (context, state) {
                  if (state.isNotEmpty) {
                    return ElevatedButton.icon(
                      icon: Icon(CupertinoIcons.delete, color: Palette.colorF04C4C),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Palette.color333333),
                        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                      ),
                      // todo: добавить обработку нажатия
                      label: Text(
                        context.$.delete,
                        style: textTheme.headlineSmall!.copyWith(height: 20 / 14) + Colors.white,
                      ),
                      onPressed: () {},
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              // todo: вынести в отдельный виджет или стиль
              ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                ),
                // todo: добавить обработку нажатия
                onPressed: () {},
                label: Text(context.$.create, style: textTheme.headlineSmall!.copyWith(height: 20 / 14)),
                icon: Icon(Icons.add, color: Palette.color1B1B1D),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is! UsersLoadedState) {
                  return AppProgressIndicator();
                }
                return UsersTable(users: state.users);
              },
            ),
          ),
        ],
      ),
    );
  }
}
