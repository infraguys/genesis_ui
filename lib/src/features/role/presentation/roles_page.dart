import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/role/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/features/role/presentation/widgets/roles_list_item.dart';
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
    return BlocBuilder<UserRolesBloc, UserRolesState>(
      builder: (context, state) {
        if (state is! UserRolesLoaded) {
          return Center(child: CupertinoActivityIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.$.users, style: TextStyle(color: Colors.white54, fontSize: 12)),
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
                  Spacer(),
                  Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: state.roles.length,
                itemBuilder: (context, index) {
                  final currentOrganization = state.roles[index];
                  return Provider.value(
                    value: currentOrganization,
                    child: RolesListItem(),
                  );
                },
                separatorBuilder: (_, _) => Divider(height: 0),
              ),
            ),
          ],
        );
      },
    );
    // return Column(
    //   spacing: 24,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text('Роли', style: textTheme.headlineMedium),
    //     BlocBuilder<UserRolesBloc, UserRolesState>(
    //       builder: (context, state) {
    //         if (state is! UserRolesLoaded) {
    //           return Expanded(child: Center(child: CupertinoActivityIndicator()));
    //         }
    //         return GridView.builder(
    //           shrinkWrap: true,
    //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    //             maxCrossAxisExtent: 320,
    //             mainAxisExtent: 250,
    //             crossAxisSpacing: 16,
    //             mainAxisSpacing: 16,
    //           ),
    //           itemCount: state.roles.toSet().toList().length + 1,
    //           itemBuilder: (context, index) {
    //             if (index == 0) {
    //               return AddRoleCardButton();
    //             }
    //             final role = state.roles[index - 1];
    //             return Card(
    //               child: Padding(
    //                 padding: const EdgeInsets.all(12.0),
    //                 child: Column(
    //                   spacing: 4,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text(
    //                           role.name,
    //                           style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
    //                         ),
    //                         Provider.value(
    //                           value: role,
    //                           child: RoleActionPopupMenuButton(),
    //                         ),
    //                       ],
    //                     ),
    //                     Text(role.createdAt.toString(), style: textTheme.bodySmall),
    //                     Text(role.description, style: textTheme.bodySmall),
    //                     SizedBox(height: 16),
    //                     // Text(
    //                     //   context.$.roles,
    //                     //   style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
    //                     // ),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       },
    //     ),
    //   ],
    // );
  }
}
