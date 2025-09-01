import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/update_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_presentation/blocs/permission_bindings_bloc/permission_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bloc/role_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/permissions_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _RoleView extends StatefulWidget {
  const _RoleView({required this.role});

  final Role role;

  @override
  State<_RoleView> createState() => _RoleViewState();
}

class _RoleViewState extends State<_RoleView> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
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
          final navigator = GoRouter.of(context);
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          if (state is RoleUpdatedState) {
            scaffoldMessenger.showSnackBar(AppSnackBar.success(context.$.success)).closed.then(navigator.pop);
          }
          context.read<PermissionsSelectionBloc>().add(PermissionsSelectionEvent.clear());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.roles),
                BreadcrumbItem(text: widget.role.name),
              ],
            ),
            ButtonsBar(
              children: [
                SaveIconButton(onPressed: () => save(context)),
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
                builder: (context, state) => switch (state) {
                  PermissionsLoadedState() => PermissionsTable(permissions: state.permissions),
                  _ => AppProgressIndicator(),
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
      final params = UpdateRoleParams(
        uuid: widget.role.uuid,
        name: _controllersManager.nameController.text,
        description: _controllersManager.descriptionController.text,
        permissions: context.read<PermissionsSelectionBloc>().state,
      );
      context.read<RoleBloc>().add(RoleEvent.update(params));
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

class RolePage extends StatelessWidget {
  const RolePage({required this.role, super.key});

  final Role role;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return PermissionBindingsBloc(context.read<IPermissionBindingsRepository>())
              ..add(PermissionBindingsEvent.getBindings(role));
          },
        ),
        BlocProvider(
          create: (context) => PermissionsBloc(context.read<IPermissionsRepository>()),
        ),
        BlocProvider(
          create: (_) => PermissionsSelectionBloc(),
        ),
        BlocProvider(
          create: (_) => RoleBloc(
            rolesRepository: context.read<IRolesRepository>(),
            permissionBindingsRepository: context.read<IPermissionBindingsRepository>(),
          ),
        ),
      ],
      child: _RoleView(role: role),
    );
  }
}
