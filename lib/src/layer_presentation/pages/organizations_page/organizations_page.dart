import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  @override
  void initState() {
    context.read<OrganizationsBloc>().add(OrganizationsEvent.getOrganizations());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationsBloc, OrganizationsState>(
      builder: (context, organizationsState) {
        if (organizationsState is! OrganizationsLoadedState) {
          return Center(child: CupertinoActivityIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.organizations.toLowerCase()),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<OrganizationsBloc, OrganizationsState>(
                builder: (_, state) {
                  if (state is! OrganizationsLoadedState) {
                    return AppProgressIndicator();
                  }
                  return OrganizationsTable(organizations: state.organizations);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
