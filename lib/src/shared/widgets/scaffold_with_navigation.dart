import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

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
        appBar: AppBar(
          actions: [
            PopupMenuButton<void>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Sign out'),
                  onTap: () {
                    // Sign out logic
                  },
                ),
              ],
              child: const Icon(Icons.notifications_none_outlined),
            ),
            const SizedBox(width: 24),
            AccountButtoon(),
            // ShowFollowerButtontton(adjustmentLabel: 'ececec', adjustFollower: adjustFollower)
          ],
        ),
        drawer: NavigationDrawer(
          tilePadding: EdgeInsetsGeometry.zero,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: goBranch,
          children: [
            NavigationDrawerDestination(icon: Icon(Icons.dashboard), label: Text(context.$.dashboard)),
            NavigationDrawerDestination(icon: Icon(Icons.laptop), label: Text('Monitoring'.hardcoded)),
          ],
        ),
        body: navigationShell,
      ),
    );
  }
}

class AccountButtoon extends StatefulWidget {
  const AccountButtoon({super.key});

  @override
  State<AccountButtoon> createState() => _AccountButtoonState();
}

class _AccountButtoonState extends State<AccountButtoon> {
  late Offset g;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        onPressed: () {
          final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
          final position = RelativeRect.fromLTRB(
            g.dx,
            g.dy,
            overlay.size.width - g.dx,
            overlay.size.height - g.dy,
          );
          showMenu<Widget>(
            context: context,
            position: position,
            items: [
              PopupMenuItem(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final user = (state as Authenticated).iamClient.user;
                    return Container(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [Text('Привет, ${user.name}')],
                        ),
                      ),
                    );
                  },
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  context.read<AuthBloc>().add(AuthEvent.signOut());
                },
                child: Text('Sign Out'),
              ),
            ],
          );
        },
        icon: Icon(Icons.account_circle_outlined),
      ),

      onTapDown: (details) {
        g = details.globalPosition;
      },
    );
  }
}

// todo(E.Koretsky): Временное решение.
class ShowFollowerButton extends StatelessWidget {
  final LayerLink layerLink = LayerLink();
  final Widget Function(CompositedTransformFollower follower) adjustFollower;
  final String adjustmentLabel;

  ShowFollowerButton({required this.adjustmentLabel, required this.adjustFollower});

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: ElevatedButton(
        onPressed: () async {
          var follower = CompositedTransformFollower(
            link: layerLink,
            targetAnchor: Alignment.bottomLeft,
            child: Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [Text('Привет, Joe')],
                ),
              ),
            ),
          );
          var entry = OverlayEntry(builder: (context) => adjustFollower(follower));
          Overlay.of(context).insert(entry);
          Future.delayed(Duration(seconds: 1), () => entry.remove());
        },
        child: Text('Show $adjustmentLabel Follower'),
      ),
    );
  }
}
