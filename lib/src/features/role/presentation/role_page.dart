import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/common/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/features/permissions/presentation/blocs/permissions_bloc.dart';
import 'package:genesis/src/features/permissions/presentation/widgets/permission_list_item.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:provider/provider.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    context.read<PermissionsBloc>().add(PermissionsEvent.getPermissions());
    // context.read<UserRolesBloc>().add(UserRolesEvent.getRoles(widget.user.uuid));
    _controllersManager = _ControllersManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // if (state is UserStateUpdateSuccess) {
          //   final snack = SnackBar(
          //     backgroundColor: Colors.green,
          //     content: Text(context.$.success),
          //   );
          //   ScaffoldMessenger.of(context).showSnackBar(snack);
          // } else if (state is UserStateFailure) {
          //   final snack = SnackBar(
          //     backgroundColor: Colors.red,
          //     content: Text(state.message),
          //   );
          //   ScaffoldMessenger.of(context).showSnackBar(snack);
          // }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      controller: _controllersManager.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Названиe',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      controller: _controllersManager.descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: context.$.description,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Text('Permissions'.hardcoded, style: TextStyle(color: Colors.white54, fontSize: 24)),
            const SizedBox(height: 24),
            Theme(
              data: Theme.of(context).copyWith(
                listTileTheme: Theme.of(context).listTileTheme.copyWith(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Checkbox(value: true, onChanged: (_) {}),
                trailing: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
                title: Text('Название'.hardcoded),
              ),
            ),
            Expanded(
              child: BlocBuilder<PermissionsBloc, PermissionsState>(
                builder: (context, state) {
                  if (state is! PermissionsLoadedState) {
                    return AppProgressIndicator();
                  }
                  return ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (_, _) => Divider(height: 0),
                    itemBuilder: (context, index) {
                      return Provider.value(
                        value: state.permissions[index],
                        child: PermissionListItem(),
                      );
                    },
                  );
                },
              ),
            ),
            // SizedBox(
            //   width: 400,
            //   child: ElevatedButton(
            //     onPressed: () => save(context),
            //     child: Text(context.$.save),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {}
  }
}

class _ControllersManager extends FormControllersManager {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  List<TextEditingController> get all => [nameController, descriptionController];

  @override
  bool get allFilled => all.every((it) => it.text.isNotEmpty);
}
