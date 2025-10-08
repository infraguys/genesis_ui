import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bloc/role_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/permissions_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/search_input.dart';
import 'package:go_router/go_router.dart';

part 'widgets/search_input.dart';

class _CreateRoleView extends StatefulWidget {
  const _CreateRoleView();

  @override
  State<_CreateRoleView> createState() => _CreateRoleViewState();
}

class _CreateRoleViewState extends State<_CreateRoleView> {
  final _formKey = GlobalKey<FormState>();

  var _name = '';
  var _description = '';

  late final PermissionsSelectionBloc _permissionsSelectionBloc;
  late final RoleBloc _roleBloc;

  @override
  void initState() {
    _permissionsSelectionBloc = context.read<PermissionsSelectionBloc>();
    _roleBloc = context.read<RoleBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RoleBloc, RoleState>(
        listenWhen: (_, current) => switch (current) {
          RoleCreatedState() || RoleFailureState() => true,
          _ => false,
        },
        listener: (context, state) {
          final messenger = ScaffoldMessenger.of(context);

          switch (state) {
            case RoleCreatedState():
              context.read<RolesBloc>().add(RolesEvent.getRoles());
              messenger.showSnackBar(AppSnackBar.success(context.$.success));
              context.pop();
            case RoleFailureState(:final message):
              messenger.showSnackBar(AppSnackBar.failure(message));
            default:
          }
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
            ButtonsBar.withoutLeftSpacer(
              children: [
                _SearchInput(),
                Spacer(),
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
                        child: TextFormField(
                          decoration: InputDecoration(hintText: context.$.name),
                          onSaved: (newValue) => _name = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.4,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: context.$.description),
                          onSaved: (newValue) => _description = newValue!,
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
      _formKey.currentState!.save();
      _roleBloc.add(
        RoleEvent.create(
          CreateRoleParams(
            name: _name,
            description: _description,
            permissions: _permissionsSelectionBloc.state,
          ),
        ),
      );
    }
  }
}

class CreateRolePage extends StatelessWidget {
  const CreateRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
            roleBindingsRepository: context.read<IRoleBindingsRepository>(),
          ),
        ),
      ],
      child: _CreateRoleView(),
    );
  }
}
