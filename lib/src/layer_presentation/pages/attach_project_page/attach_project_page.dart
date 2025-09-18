import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/projects_table.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/role_list_page/widgets/roles_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _AttachProjectView extends StatefulWidget {
  const _AttachProjectView();

  @override
  State<_AttachProjectView> createState() => _AttachProjectViewState();
}

class _AttachProjectViewState extends State<_AttachProjectView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RoleBindingsBloc, RoleBindingsState>(
      listenWhen: (_, current) => switch (current) {
        RoleBindingsCreatedState() => true,
        RoleBindingsDeletedState() => true,
        _ => false,
      },
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        var snack = AppSnackBar.success(context.$.success);

        switch (state) {
          case RoleBindingsFailureState(:final message):
            snack = AppSnackBar.failure(message);
          default:
        }
        scaffoldMessenger.showSnackBar(snack).closed.then((_) => navigator.pop(true));
      },
      child: SingleChildScrollView(
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.users),
                BreadcrumbItem(text: 'cecece'),
                BreadcrumbItem(text: 'attach_project'),
              ],
            ),
            ButtonsBar(
              children: [
                SaveIconButton(
                  onPressed: () {
                    final listOfParams = context.read<RolesSelectionBloc>().state.map(
                      (role) {
                        return CreateRoleBindingParams(
                          userUUID: UserUUID(GoRouterState.of(context).pathParameters['uuid']!),
                          roleUUID: role.uuid,
                          projectUUID: context.read<ProjectsSelectionBloc>().state.single.uuid,
                        );
                      },
                    ).toList();
                    context.read<RoleBindingsBloc>().add(RoleBindingsEvent.createBindings(listOfParams));
                  },
                ),
              ],
            ),
            Text(context.$.projects, style: TextStyle(color: Colors.white54, fontSize: 24)),
            SizedBox(
              height: 405,
              child: BlocConsumer<ProjectsBloc, ProjectsState>(
                listenWhen: (_, current) => current is ProjectsLoadedState,
                listener: (context, state) {
                  context.read<ProjectsSelectionBloc>().add(ProjectsSelectionEvent.clear());
                },
                buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                builder: (_, state) => switch (state) {
                  ProjectsLoadedState(:final projects) => ProjectsTable(projects: projects, allowMultiSelect: false),
                  _ => AppProgressIndicator(),
                },
              ),
            ),
            Text(context.$.roles, style: TextStyle(color: Colors.white54, fontSize: 24)),
            SizedBox(
              height: 405,
              child: BlocConsumer<RolesBloc, RolesState>(
                listenWhen: (_, current) => current is RolesLoadedState,
                listener: (context, state) {
                  context.read<RolesSelectionBloc>().add(RolesSelectionEvent.clear());
                },
                builder: (_, state) => switch (state) {
                  RolesLoadedState(:final roles) => RolesTable(roles: roles),
                  _ => AppProgressIndicator(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttachProjectPage extends StatelessWidget {
  const AttachProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => RolesSelectionBloc(),
        ),
        BlocProvider(
          create: (_) => ProjectsSelectionBloc(),
        ),
      ],
      child: _AttachProjectView(),
    );
  }
}
