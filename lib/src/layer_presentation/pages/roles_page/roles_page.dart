import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/delete_roles_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/search_input.dart';

class RolesPage extends StatelessWidget {
  const RolesPage({super.key});

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
            SearchInput(),
            Spacer(),
            DeleteRoleIconButton(),
            RolesCreateIconButton(),
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
