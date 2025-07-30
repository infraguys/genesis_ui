import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/common/shared_widgets/me_appbar_widget.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: SvgPicture.asset('assets/images/purple_logo.svg'),
        ),
        actions: [
          const Icon(Icons.notifications_none_outlined, color: Palette.colorAFA8A4),
          const SizedBox(width: 16),
          MeAppbarWidget(),
        ],
      ),
      // appBar: AppBar(
      //
      //   backgroundColor: Colors.green,
      //   actions: [
      //     PopupMenuButton<void>(
      //       itemBuilder: (context) => [
      //         PopupMenuItem(
      //           child: const Text('Notification'),
      //           onTap: () {
      //             // Sign out logic
      //           },
      //         ),
      //       ],
      //       child: const Icon(Icons.notifications_none_outlined),
      //     ),
      //     const SizedBox(width: 24),
      //     MeAppbarWidget(),
      //   ],
      // ),
      // drawer: NavigationDrawer(
      //   tilePadding: EdgeInsetsGeometry.zero,
      //   selectedIndex: navigationShell.currentIndex,
      //   onDestinationSelected: (index) {},
      //   children: [],
      // ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Drawer(
              backgroundColor: Palette.color333333,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(
                  spacing: 4.0,
                  children: [
                    ListTile(
                      leading: Icon(Icons.dashboard),
                      selected: GoRouterState.of(context).matchedLocation.startsWith('/'),
                      title: Text(context.$.main),
                      onTap: () => context.goNamed(AppRoutes.main.name),
                    ),
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
                    ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      selected: GoRouterState.of(context).matchedLocation.startsWith('/roles'),
                      title: Text(context.$.role(3)),
                      onTap: () => context.goNamed(AppRoutes.roles.name),
                    ),
                    ListTile(
                      leading: Icon(Icons.business_sharp),
                      selected: GoRouterState.of(context).matchedLocation.startsWith('/organizations'),
                      title: Text('Организации'.hardcoded),
                      onTap: () => context.goNamed(AppRoutes.organizations.name),
                    ),
                    const SizedBox(height: 20.0),
                    ListTile(
                      leading: Icon(Icons.extension),
                      tileColor: Colors.white,
                      textColor: Palette.color333333,
                      title: Text(context.$.extensions),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20.0, vertical: 32.0),
              child: navigationShell,
            ),
          ),
        ],
      ),
    );
  }
}
