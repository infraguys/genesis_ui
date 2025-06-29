import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/shared/widgets/me_appbar_widget.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          final snackBar = SnackBar(
            content: const Text('Yay! SignIn was Success!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
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
                      child: SvgPicture.asset(
                        'assets/images/logo.svg',
                        width: 50,
                        height: 50,
                      ),
                      margin: EdgeInsets.zero,
                    ),
                  ),
                  ListTile(title: Text('dashboard'.hardcoded)),
                  ExpansionTile(
                    title: Text('iam'.hardcoded),
                    children: [
                      ListTile(
                        title: Text('Пользователи'.hardcoded),
                        onTap: () => context.goNamed(AppRoutes.users.name),
                      ),
                      ListTile(
                        title: Text('Проекты'.hardcoded),
                        onTap: () => context.goNamed(AppRoutes.projects.name),
                      ),
                      ListTile(
                        title: Text('Роли'.hardcoded),
                        onTap: () => context.goNamed(AppRoutes.roles.name),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text('dashboard'.hardcoded),
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
                        children: [const Icon(Icons.notifications_none_outlined), MeAppbarWidget()],
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
      ),
    );
  }
}
