import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/common/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/features/common/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/features/permissions/presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/features/permissions/presentation/blocs/permissions_selection_bloc%20/permissions_selection_bloc%20.dart';
import 'package:genesis/src/features/permissions/presentation/widgets/permissions_table.dart';
import 'package:genesis/src/features/role/presentation/blocs/role_editor_bloc/role_editor_bloc.dart';
import 'package:genesis/src/theming/palette.dart';

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
      body: BlocListener<RoleEditorBloc, RoleEditorState>(
        listener: (context, state) {
          if (state is RoleEditorStateSuccess) {
            _controllersManager.clear();
            context.read<PermissionsSelectionBloc>().add(PermissionsSelectionEvent.unSelectAll());
            final snack = SnackBar(
              backgroundColor: Palette.color6DCF91,
              content: Text(context.$.success),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }
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
          spacing: 24,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.role(3).toLowerCase()),
                BreadcrumbItem(text: context.$.create.toLowerCase()),
              ],
            ),
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  SizedBox(
                    width: 400,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      controller: _controllersManager.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: context.$.name,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required'.hardcoded;
                        }
                        return null;
                      },
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
            Text(context.$.permissions, style: TextStyle(color: Colors.white54, fontSize: 24)),
            Expanded(
              child: BlocBuilder<PermissionsBloc, PermissionsState>(
                builder: (context, state) {
                  if (state is! PermissionsLoadedState) {
                    return AppProgressIndicator();
                  }
                  return PermissionsTable(permissions: state.permissions);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Palette.color6DCF91),
                    ),
                    onPressed: () => save(context),
                    child: Text(context.$.create),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<RoleEditorBloc>().add(
        RoleEditorEvent.create(
          name: _controllersManager.nameController.text,
          description: _controllersManager.descriptionController.text,
          permission: context.read<PermissionsSelectionBloc>().state.first,
        ),
      );
    }
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
