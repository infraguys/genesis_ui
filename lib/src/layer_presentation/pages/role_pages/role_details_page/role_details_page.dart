import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/update_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_presentation/blocs/permission_bindings_bloc/permission_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bloc/role_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/confirmation_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/permissions_table.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/search_input.dart';
import 'package:go_router/go_router.dart';

part 'widgets/delete_role_btn.dart';
part 'widgets/search_input.dart';

class _RoleDetailsView extends StatefulWidget {
  const _RoleDetailsView({required this.uuid});

  final RoleUUID uuid;

  @override
  State<_RoleDetailsView> createState() => _RoleDetailsViewState();
}

class _RoleDetailsViewState extends State<_RoleDetailsView> {
  final _formKey = GlobalKey<FormState>();
  late RoleBloc _roleBloc;

  late String _name;
  late String _description;

  @override
  void initState() {
    _roleBloc = context.read<RoleBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoleBloc, RoleState>(
        listener: (context, state) {
          final messenger = ScaffoldMessenger.of(context);

          switch (state) {
            case RoleLoadedState(:final role):
            case RoleUpdatedState(:final role):
              context.read<RoleBloc>().add(RoleEvent.get(widget.uuid));
              messenger.showSnackBar(AppSnackBar.success(context.$.msgRoleUpdated(role.name)));
              context.read<RolesBloc>().add(RolesEvent.getRoles());
            case RoleDeletedState(:final role):
              messenger.showSnackBar(AppSnackBar.success(context.$.msgRoleDeleted(role.name)));
              context.read<RolesBloc>().add(RolesEvent.getRoles());
              context.pop();
            default:
          }

          // context.read<PermissionsSelectionBloc>().add(PermissionsSelectionEvent.clear());
        },
        builder: (context, state) {
          if (state is! RoleLoadedState) {
            return const AppProgressIndicator();
          }

          final role = state.role;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Breadcrumbs(
                items: [
                  BreadcrumbItem(text: context.$.roles),
                  BreadcrumbItem(text: role.name),
                ],
              ),
              ButtonsBar.withoutLeftSpacer(
                children: [
                  _SearchInput(),
                  Spacer(),
                  _DeleteRoleButton(role: role),
                  SaveIconButton(onPressed: save),
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
                        decoration: InputDecoration(hintText: context.$.name),
                        onSaved: (newValue) => _name = newValue!,
                        validator: (value) => switch (value) {
                          _ when value!.isEmpty => context.$.requiredField,
                          _ => null,
                        },
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        decoration: InputDecoration(hintText: context.$.description),
                        onSaved: (newValue) => _description = newValue!,
                      ),
                    ),
                  ],
                ),
              ),
              Text(context.$.permissions, style: TextStyle(color: Colors.white54, fontSize: 24)),
              Expanded(
                child: BlocBuilder<PermissionsBloc, PermissionsState>(
                  builder: (context, state) {
                    return switch (state) {
                      // todo: подумать как переписать
                      PermissionsLoadedState(:final permissions) =>
                        BlocListener<PermissionBindingsBloc, PermissionBindingsState>(
                          listenWhen: (_, current) => current is PermissionBindingsLoaded,
                          listener: (context, state) {
                            if (state is PermissionBindingsLoaded) {
                              context.read<PermissionsSelectionBloc>().add(
                                PermissionsSelectionEvent.setCheckedFromResponse(
                                  bindings: state.bindings,
                                  allPermissions: permissions,
                                ),
                              );
                            }
                          },
                          child: PermissionsTable(permissions: permissions),
                        ),
                      _ => AppProgressIndicator(),
                    };
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _roleBloc.add(
        RoleEvent.update(
          UpdateRoleParams(
            uuid: widget.uuid,
            name: _name,
            description: _description,
            permissions: context.read<PermissionsSelectionBloc>().state,
          ),
        ),
      );
    }
  }
}

class RoleDetailsPage extends StatelessWidget {
  const RoleDetailsPage({required this.uuid, super.key});

  final RoleUUID uuid;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return PermissionBindingsBloc(context.read<IPermissionBindingsRepository>())
              ..add(PermissionBindingsEvent.getBindings(uuid));
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
            roleBindingsRepository: context.read<IRoleBindingsRepository>(),
          )..add(RoleEvent.get(uuid)),
        ),
      ],
      child: _RoleDetailsView(uuid: uuid),
    );
  }
}
