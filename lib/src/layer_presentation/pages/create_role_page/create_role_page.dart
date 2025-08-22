import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bloc/role_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/permissions_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class CreateRolePage extends StatefulWidget {
  const CreateRolePage({super.key});

  @override
  State<CreateRolePage> createState() => _CreateRolePageState();
}

class _CreateRolePageState extends State<CreateRolePage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;
  late final PermissionsBloc _permissionsBloc;
  late final PermissionsSelectionBloc _permissionsSelectionBloc;
  late final RoleBloc _roleBloc;

  @override
  void initState() {
    _permissionsBloc = context.read<PermissionsBloc>();
    _permissionsSelectionBloc = context.read<PermissionsSelectionBloc>();
    _roleBloc = context.read<RoleBloc>();

    _permissionsBloc.add(PermissionsEvent.getPermissions());

    _controllersManager = _ControllersManager();
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
        listenWhen: (_, current) => switch (current) {
          RoleCreatedState() => true,
          RoleFailureState() => true,
          _ => false,
        },
        listener: (context, state) {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          final navigator = GoRouter.of(context);

          switch (state) {
            case RoleCreatedState():
              context.read<RolesBloc>().add(RolesEvent.getRoles());
              scaffoldMessenger.showSnackBar(AppSnackBar.success(context.$.success)).closed.then(navigator.pop);
            case RoleFailureState(:final message):
              scaffoldMessenger.showSnackBar(AppSnackBar.failure(message));
            default:
          }
          // _permissionsSelectionBloc.add(PermissionsSelectionEvent.clear());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.roles),
                BreadcrumbItem(text: context.$.create),
              ],
            ),
            ButtonsBar(
              children: [
                SaveIconButton(onPressed: save),
              ],
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Form(
                  key: _formKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.4,
                        child: AppTextInput(
                          controller: _controllersManager.nameController,
                          hintText: context.$.name,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.4,
                        child: AppTextInput(
                          controller: _controllersManager.descriptionController,
                          hintText: context.$.description,
                        ),
                      ),
                    ],
                  ),
                );
              },
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

  void save() {
    if (_formKey.currentState!.validate()) {
      _roleBloc.add(
        RoleEvent.create(
          CreateRoleParams(
            name: _controllersManager.nameController.text,
            description: _controllersManager.descriptionController.text,
            permissions: _permissionsSelectionBloc.state,
          ),
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
}
