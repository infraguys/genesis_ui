import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/common/shared_widgets/me_appbar_widget.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    return Scaffold(
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
          Drawer(
            backgroundColor: Colors.grey.shade200,
            width: 220,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(border: BoxBorder.fromBorderSide(BorderSide.none)),
                    margin: EdgeInsets.zero,
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                ListTile(
                  selected: GoRouterState.of(context).topRoute?.name == AppRoutes.dashboard.name,
                  title: Text(context.$.dashboard),
                  onTap: () => context.goNamed(AppRoutes.dashboard.name),
                ),
                ExpansionTile(
                  title: Text(context.$.iam),
                  children: [
                    ListTile(
                      selected: GoRouterState.of(context).topRoute?.name == AppRoutes.users.name,
                      title: Text(context.$.users),
                      onTap: () => context.goNamed(AppRoutes.users.name),
                    ),
                    ListTile(
                      selected: GoRouterState.of(context).topRoute?.name == AppRoutes.projects.name,
                      title: Text(context.$.projects),
                      onTap: () => context.goNamed(AppRoutes.projects.name),
                    ),
                    ListTile(
                      selected: GoRouterState.of(context).topRoute?.name == AppRoutes.roles.name,
                      title: Text(context.$.roles),
                      onTap: () => context.goNamed(AppRoutes.roles.name),
                    ),
                  ],
                ),
              ],
            ),
          ),
          VerticalDivider(color: Colors.white, endIndent: 50, indent: 50, width: 1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 20,
                      children: [
                        const Icon(Icons.notifications_none_outlined),
                        MeAppbarWidget(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
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
