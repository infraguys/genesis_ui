import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/role_list_page/widgets/roles_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

part './widgets/create_role_btn.dart';
part './widgets/delete_roles_btn.dart';

class _RoleListView extends StatelessWidget {
  const _RoleListView();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.roles),
          ],
        ),
        ButtonsBar.withoutLeftSpacer(
          children: [
            // SearchInput(),
            Spacer(),
            _DeleteRolesButton(),
            _CreateRoleButton(),
          ],
        ),
        Expanded(
          child: BlocConsumer<RolesBloc, RolesState>(
            listenWhen: (_, current) => current is RolesLoadedState,
            listener: (context, _) {
              context.read<RolesSelectionBloc>().add(RolesSelectionEvent.clear());
            },
            builder: (context, state) => switch (state) {
              RolesLoadedState(:final roles) => RolesTable(roles: roles),
              _ => AppProgressIndicator(),
            },
          ),
        ),
      ],
    );
  }
}

class RoleListPage extends StatelessWidget {
  const RoleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RolesSelectionBloc(),
      child: _RoleListView(),
    );
  }
}
