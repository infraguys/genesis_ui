import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/pages/create_organization_page/create_organization_page.dart';
import 'package:genesis/src/features/organizations/presentation/pages/organization_list_page/widgets/organizations_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';

part 'widgets/delete_organization_btn.dart';

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
      child: PageLayout(
        breadcrumbs: [
          BreadcrumbItem(text: context.$.organizations),
        ],
        buttons: [
          _DeleteOrganizationButton(),
          CreateIconButton(
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => Dialog(child: CreateOrganizationPage()),
              );
            },
          ),
        ],
        child: Expanded(
          child: BlocBuilder<OrganizationsBloc, OrganizationsState>(
            buildWhen: (_, current) => current is OrganizationsLoadedState || current is OrganizationsLoadingState,
            builder: (_, state) {
              return switch (state) {
                _ when state is! OrganizationsLoadedState => AppProgressIndicator(),
                _ => OrganizationsTable(organizations: state.organizations),
              };
            },
          ),
        ),
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
