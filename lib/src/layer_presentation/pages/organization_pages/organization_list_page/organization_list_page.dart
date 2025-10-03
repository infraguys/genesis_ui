import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organization_pages/organization_list_page/widgets/organizations_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirmation_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/create_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

part './widgets/create_organization_btn.dart';
part './widgets/delete_organization_btn.dart';

class _OrganizationListView extends StatefulWidget {
  const _OrganizationListView();

  @override
  State<_OrganizationListView> createState() => _OrganizationListViewState();
}

class _OrganizationListViewState extends State<_OrganizationListView> {
  @override
  void initState() {
    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OrganizationsBloc, OrganizationsState>(
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);
            switch (state) {
              case OrganizationsLoadedState():
                context.read<OrganizationsSelectionBloc>().onClear();

              case OrganizationsDeletedState(:final organizations) when organizations.length == 1:
                messenger.showSnackBar(
                  AppSnackBar.success(context.$.msgOrganizationDeleted(organizations.single.name)),
                );
              case OrganizationsDeletedState(:final organizations) when organizations.length > 1:
                messenger.showSnackBar(
                  AppSnackBar.success(context.$.msgOrganizationsDeleted(organizations.length)),
                );

              case OrganizationsPermissionFailureState(:final message):
                messenger.showSnackBar(AppSnackBar.failure(context.$.msgPermissionDenied(message)));
              default:
            }
          },
        ),
      ],
      child: Column(
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
              _DeleteOrganizationButton(),
              _CreateOrganizationButton(),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<OrganizationsBloc, OrganizationsState>(
              buildWhen: (_, current) => current is OrganizationsLoadedState || current is OrganizationsLoadingState,
              builder: (_, state) => switch (state) {
                OrganizationsLoadedState(:final organizations) => OrganizationsTable(organizations: organizations),
                _ => AppProgressIndicator(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrganizationListPage extends StatelessWidget {
  const OrganizationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrganizationsSelectionBloc(),
      child: _OrganizationListView(),
    );
  }
}
