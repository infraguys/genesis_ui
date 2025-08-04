import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/common/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/features/common/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/features/role/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/features/role/presentation/widgets/roles_table.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

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
    final textTheme = TextTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.role(3).toLowerCase()),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Spacer(),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
              ),
              onPressed: () {
                context.goNamed(AppRoutes.createRole.name);
              },
              label: Text(context.$.create, style: textTheme.headlineSmall!.copyWith(height: 20 / 14)),
              icon: Icon(Icons.add, color: Palette.color1B1B1D),
            ),
          ],
        ),
        const SizedBox(height: 24),
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
