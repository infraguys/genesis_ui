import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bloc/role_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/permissions_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:genesis/src/theming/palette.dart';

class RolePage extends StatefulWidget {
  const RolePage({required this.role, super.key});

  final Role role;

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    context.read<PermissionsBloc>().add(PermissionsEvent.getPermissions());
    _controllersManager = _ControllersManager(widget.role);
    super.initState();
  }

  @override
  void dispose() {
    _controllersManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RoleBloc, RoleState>(
        listener: (context, state) {
          if (state is RoleSuccessState) {
            _controllersManager.clear();
            context.read<PermissionsSelectionBloc>().add(PermissionsSelectionEvent.unSelectAll());
            final snack = SnackBar(
              backgroundColor: Palette.color6DCF91,
              content: Text(context.$.success),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.role(3)),
                BreadcrumbItem(text: context.$.create),
              ],
            ),
            ButtonsBar(children: [SaveIconButton(onPressed: () => save(context))]),
            Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  SizedBox(
                    width: 400,
                    child: AppTextInput(
                      controller: _controllersManager.nameController,
                      hintText: context.$.name,
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
                    child: AppTextInput(
                      controller: _controllersManager.descriptionController,
                      hintText: context.$.description,
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
          ],
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final params = CreateRoleParams(
        name: _controllersManager.nameController.text,
        description: _controllersManager.descriptionController.text,
        permissions: context.read<PermissionsSelectionBloc>().state,
      );
      context.read<RoleBloc>().add(RoleEvent.create(params));
    }
  }
}

class _ControllersManager extends FormControllersManager {
  _ControllersManager(Role role)
    : nameController = TextEditingController(text: role.name),
      descriptionController = TextEditingController(text: role.description);

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  @override
  List<TextEditingController> get all => [nameController, descriptionController];
}
