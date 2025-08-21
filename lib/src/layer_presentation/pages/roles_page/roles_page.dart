import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_create_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_delete_icon_button.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/widgets/roles_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<RolesPage> {
  @override
  void initState() {
    context.read<RolesBloc>().add(RolesEvent.getRoles());
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
            // todo: убрать аргумент
            BreadcrumbItem(text: context.$.role(3).toLowerCase()),
          ],
        ),
        ButtonsBar(
          children: [
            RolesDeleteIconButton(),
            RolesCreateIconButton(),
          ],
        ),
        Expanded(
          child: BlocBuilder<RolesBloc, RolesState>(
            builder: (context, state) => switch (state) {
              RolesLoaded(:final roles) => RolesTable(roles: roles),
              _ => AppProgressIndicator(),
            },
          ),
        ),
      ],
    );
  }
}
