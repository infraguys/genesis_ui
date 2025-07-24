import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
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
        actions: [
          const Icon(Icons.notifications_none_outlined),
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
      //     // PopupMenuButton<void>(
      //     //   itemBuilder: (context) => [
      //     //     PopupMenuItem(
      //     //       onTap: () {
      //     //         context.read<AuthBloc>().add(AuthEvent.signOut());
      //     //       },
      //     //       child: Text('Sign Out'),
      //     //     ),
      //     //   ],
      //     //   child: const Icon(Icons.account_circle_outlined),
      //     // ),
      //   ],
      // ),
      // drawer: NavigationDrawer(
      //   tilePadding: EdgeInsetsGeometry.zero,
      //   selectedIndex: navigationShell.currentIndex,
      //   onDestinationSelected: (index) {
      //     // if (index == 2) {
      //     //   context.read<AuthBloc>().add(AuthEvent.signOut());
      //     // } else {
      //       goBranch(index);
      //     // }
      //   },
      //   children: [
      //     NavigationDrawerDestination(icon: Icon(Icons.dashboard), label: Text(context.$.dashboard)),
      //     NavigationDrawerDestination(icon: Icon(Icons.supervised_user_circle_sharp), label: Text('Iam')),
      //     // NavigationDrawerDestination(icon: Icon(Icons.laptop), label: Text('Monitoring'.hardcoded)),
      //     // Divider(height: 1, color: Colors.grey.shade200),
      //     // NavigationDrawerDestination(
      //     //   icon: Icon(Icons.logout),
      //     //   label: Text('Sign out'.hardcoded),
      //     // ),
      //   ],
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
                    // SizedBox(
                    //   height: 100,
                    //   child: Container(
                    //     decoration: BoxDecoration(border: BoxBorder.fromBorderSide(BorderSide.none)),
                    //     margin: EdgeInsets.zero,
                    //     child: SvgPicture.asset(
                    //       'assets/images/logo.svg',
                    //       width: 50,
                    //       height: 50,
                    //     ),
                    //   ),
                    // ),
                    ListTile(
                      leading: Icon(Icons.dashboard),
                      selected: GoRouterState.of(context).topRoute?.name == AppRoutes.dashboard.name,
                      title: Text('Главная'),
                      onTap: () => context.goNamed(AppRoutes.dashboard.name),
                    ),
                    ListTile(
                      leading: Icon(CupertinoIcons.person_2_fill),
                      selected: GoRouterState.of(context).topRoute?.name == AppRoutes.users.name,
                      title: Text(context.$.users),
                      onTap: () => context.goNamed(AppRoutes.users.name),
                    ),
                    ListTile(
                      leading: Icon(Icons.folder_copy_rounded),
                      selected: GoRouterState.of(context).topRoute?.name == AppRoutes.projects.name,
                      title: Text(context.$.projects),
                      onTap: () => context.goNamed(AppRoutes.projects.name),
                    ),
                    ListTile(
                      leading: Icon(Icons.admin_panel_settings),
                      selected: GoRouterState.of(context).topRoute?.name == AppRoutes.roles.name,
                      title: Text(context.$.roles),
                      onTap: () => context.goNamed(AppRoutes.roles.name),
                    ),
                    const SizedBox(height: 20.0),
                    ListTile(
                      leading: Icon(Icons.extension),
                      tileColor: Colors.white,
                      title: Text('Extensions'),
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
