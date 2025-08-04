import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_list_item.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:provider/provider.dart';

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
                BreadcrumbItem(text: 'organizations'.hardcoded),
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(value: true, onChanged: (_) {}),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              title: Row(
                spacing: 48,
                children: [
                  Expanded(flex: 2, child: Text('Имя')),
                  Expanded(child: Text(context.$.status)),
                  Expanded(flex: 4, child: Text('Created At')),
                  Spacer(flex: 2),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: organizationsState.organizations.length,
                itemBuilder: (context, index) {
                  final currentOrganization = organizationsState.organizations[index];
                  return Provider.value(
                    value: currentOrganization,
                    child: OrganizationsListItem(),
                  );
                },
                separatorBuilder: (_, _) => Divider(height: 0),
              ),
            ),
          ],
        );
      },
    );
  }
}
