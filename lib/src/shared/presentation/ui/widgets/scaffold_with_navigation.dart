import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genesis/main.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/iam_client/domain/params/refresh_token_params.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/shared/presentation/extensions/permission_names_ext.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/me_appbar_widget.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    return Scaffold(
      body: Row(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              authState as AuthenticatedAuthState;
              return Drawer(
                backgroundColor: Palette.color333333,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.0,
                    children: [
                      _Header(scope: authState.scope),
                      Divider(color: Palette.color1B1B1D, thickness: 1),
                      ListTile(
                        leading: Icon(Icons.dashboard),
                        selected: GoRouterState.of(context).matchedLocation == '/',
                        title: Text(context.$.main),
                        onTap: () => context.goNamed(AppRoutes.main.name),
                      ),
                      if (context.permissionNames.users.canListAll)
                        ListTile(
                          leading: Icon(CupertinoIcons.person_2_fill),
                          selected: GoRouterState.of(context).matchedLocation.startsWith('/users'),
                          title: Text(context.$.users),
                          onTap: () => context.goNamed(AppRoutes.users.name),
                        ),
                      ListTile(
                        leading: Icon(Icons.folder_copy_rounded),
                        selected: GoRouterState.of(context).matchedLocation.startsWith('/projects'),
                        title: Text(context.$.projects),
                        onTap: () => context.goNamed(AppRoutes.projects.name),
                      ),
                      if (context.permissionNames.roles.canRead)
                        ListTile(
                          leading: Icon(Icons.admin_panel_settings),
                          selected: GoRouterState.of(context).matchedLocation.startsWith('/roles'),
                          title: Text(context.$.roles),
                          onTap: () => context.goNamed(AppRoutes.roles.name),
                        ),
                      if (context.permissionNames.organizations.canReadAll)
                        ListTile(
                          leading: Icon(Icons.business_sharp),
                          selected: GoRouterState.of(context).matchedLocation.startsWith('/organizations'),
                          title: Text(context.$.organizations),
                          onTap: () => context.goNamed(AppRoutes.organizations.name),
                        ),
                      ListTile(
                        leading: Icon(Icons.hub_rounded),
                        selected: GoRouterState.of(context).matchedLocation.startsWith('/nodes'),
                        title: Text(context.$.nodes),
                        onTap: () {
                          context.goNamed(AppRoutes.nodes.name);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.storage_rounded),
                        selected: GoRouterState.of(context).matchedLocation.startsWith('/dbaas'),
                        title: Text(context.$.dbaas),
                        onTap: () {
                          context.goNamed(AppRoutes.instances.name);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.only(right: 8, left: 16.0),
                          leading: Icon(Icons.extension),
                          title: Text(context.$.elements),
                          children: [
                            const SizedBox(height: 4.0),
                            ListTile(
                              leading: Icon(CupertinoIcons.square_grid_2x2),
                              title: Text(context.$.allElements),
                              onTap: () {
                                context.goNamed(AppRoutes.allExtensions.name);
                              },
                            ),
                            const SizedBox(height: 4.0),
                            ListTile(
                              leading: Icon(CupertinoIcons.square_grid_2x2_fill),
                              title: Text(context.$.installed),
                              onTap: () {
                                // todo: посмотреть что будет с кнопкой назад
                                context.replaceNamed(AppRoutes.installedExtensions.name);
                              },
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      ListTile(
                        leading: Icon(CupertinoIcons.restart),
                        title: Text('Restart'.hardcoded),
                        onTap: () => App.restartApplication(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: AppBar(
                    actions: [
                      const Icon(Icons.notifications_none_outlined, color: Palette.colorAFA8A4),
                      const SizedBox(width: 16),
                      MeAppbarWidget(),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0, vertical: 8.0),
                    child: navigationShell,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.scope,
    super.key,  // ignore: unused_element_parameter
  });

  final String scope;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/images/purple_logo.svg'),
          LayoutBuilder(
            builder: (context, constraints) {
              return BlocBuilder<ProjectsBloc, ProjectsState>(
                builder: (context, state) {
                  final bloc = context.read<AuthBloc>();

                  late final List<Project> projects;
                  if (state is! ProjectsLoadedState) {
                    projects = List.empty();
                  } else {
                    projects = state.projects;
                  }

                  return DropdownMenu<ProjectID>(
                    enableSearch: false,
                    requestFocusOnTap: false,
                    // todo(Koretsky): немного переделать
                    initialSelection: projects.isNotEmpty
                        ? projects.firstWhereOrNull((it) => it.id.value == scope)?.id
                        : null,
                    width: double.infinity,
                    menuStyle: MenuStyle(
                      fixedSize: WidgetStatePropertyAll(Size(constraints.maxWidth, double.nan)),
                    ),
                    onSelected: (value) {
                      bloc.add(
                        AuthEvent.refreshToken(
                          RefreshTokenParams(
                            refreshToken: (bloc.state as AuthenticatedAuthState).refreshToken,
                            scope: value!.value,
                          ),
                        ),
                      );
                    },
                    dropdownMenuEntries: projects.map(
                      (e) {
                        return DropdownMenuEntry(
                          label: e.name,
                          value: e.id,
                          leadingIcon: Icon(
                            Icons.folder_copy_rounded,
                            color: Palette.colorAFA8A4,
                          ),
                        );
                      },
                    ).toList(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
