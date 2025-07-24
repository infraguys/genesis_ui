import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/role/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/features/role/presentation/widgets/add_role_card_button.dart';
import 'package:genesis/src/features/role/presentation/widgets/role_action_popup_menu_nutton.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Роли', style: textTheme.headlineMedium),
        BlocBuilder<UserRolesBloc, UserRolesState>(
          builder: (context, state) {
            if (state is! UserRolesLoaded) {
              return Expanded(child: Center(child: CupertinoActivityIndicator()));
            }
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                mainAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.roles.toSet().toList().length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AddRoleCardButton();
                }
                final role = state.roles[index - 1];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              role.name,
                              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Provider.value(
                              value: role,
                              child: RoleActionPopupMenuButton(),
                            ),
                          ],
                        ),
                        Text(role.createdAt.toString(), style: textTheme.bodySmall),
                        Text(role.description, style: textTheme.bodySmall),
                        SizedBox(height: 16),
                        // Text(
                        //   context.$.roles,
                        //   style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
