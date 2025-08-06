import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/widgets/organizations_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

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
    final textTheme = TextTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(
          items: [
            BreadcrumbItem(text: context.$.organizations),
          ],
        ),
        const SizedBox(height: 24),
        // todo: вынести в отдельный виджет или стиль
        Row(
          children: [
            Spacer(),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
              ),
              onPressed: () {
                context.goNamed(AppRoutes.createOrganization.name);
              },
              label: Text(context.$.create, style: textTheme.headlineSmall!.copyWith(height: 20 / 14)),
              icon: Icon(Icons.add, color: Palette.color1B1B1D),
            ),
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
  }
}
