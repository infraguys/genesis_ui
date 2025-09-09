import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';

class _OrganizationsView extends StatefulWidget {
  const _OrganizationsView();

  @override
  State<_OrganizationsView> createState() => _OrganizationsViewState();
}

class _OrganizationsViewState extends State<_OrganizationsView> {
  @override
  void initState() {
    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.organizations),
          ],
        ),
        const SizedBox(height: 24),
        ButtonsBar.withoutLeftSpacer(
          children: [
            // SearchInput(),
            Spacer(),
            OrganizationsDeleteIconButton(),
            OrganizationsCreateIconButton(),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: BlocConsumer<OrganizationsBloc, OrganizationsState>(
            listenWhen: (_, current) => current is OrganizationsLoadedState,
            listener: (context, _) {
              context.read<OrganizationsSelectionBloc>().add(OrganizationsSelectionEvent.clear());
            },
            builder: (_, state) => switch (state) {
              OrganizationsLoadedState(:final organizations) => OrganizationsTable(organizations: organizations),
              _ => AppProgressIndicator(),
            },
          ),
        ),
      ],
    );
  }
}

class OrganizationsPage extends StatelessWidget {
  const OrganizationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationsSelectionBloc(),
      child: _OrganizationsView(),
    );
  }
}
