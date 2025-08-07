import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_table.dart';
import 'package:genesis/src/layer_presentation/shared_blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<RolesPage> {
  late final AuthenticatedAuthState authState;

  @override
  void initState() {
    authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
    context.read<UserRolesBloc>().add(UserRolesEvent.getRolesByUserUuid(authState.user.uuid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.role(3).toLowerCase()),
          ],
        ),
        Row(
          spacing: 4.0,
          children: [
            Spacer(),
            RolesDeleteIconButton(),
            RolesCreateIconButton(),
          ],
        ),
        Expanded(
          child: BlocBuilder<UserRolesBloc, UserRolesState>(
            builder: (context, state) {
              if (state is! UserRolesLoaded) {
                return AppProgressIndicator();
              }
              return RolesTable(roles: state.roles);
            },
          ),
        ),
      ],
    );
  }
}
