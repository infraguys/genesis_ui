import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/role/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/features/role/presentation/widgets/roles_list_item.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<RolesPage> {
  late final AuthenticatedAuthState authState;

  @override
  void initState() {
    authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
    context.read<UserRolesBloc>().add(UserRolesEvent.getRoles(authState.user.uuid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.$.users, style: TextStyle(color: Colors.white54, fontSize: 12)),
        const SizedBox(height: 24),
        Row(
          children: [
            Spacer(),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
                padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
              ),
              onPressed: () {
                context.goNamed(AppRoutes.createRole.name);
              },
              label: Text(context.$.create, style: textTheme.headlineSmall!.copyWith(height: 20 / 14)),
              icon: Icon(Icons.add, color: Palette.color1B1B1D),
            ),
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
              Expanded(flex: 2, child: Text(context.$.role(1))),
              Expanded(child: Text(context.$.status)),
              Expanded(flex: 4, child: Text('Created At')),
              Spacer(flex: 2),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<UserRolesBloc, UserRolesState>(
            builder: (context, state) {
              if (state is! UserRolesLoaded) {
                return Center(child: CupertinoActivityIndicator());
              }
              return ListView.separated(
                itemCount: state.roles.length,
                separatorBuilder: (_, _) => Divider(height: 0),
                itemBuilder: (_, index) {
                  return Provider.value(
                    value: state.roles[index],
                    child: RolesListItem(),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
