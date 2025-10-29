import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/create_pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_user_bloc/pg_user_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_users_bloc/pg_users_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _View extends StatefulWidget {
  const _View({
    required this.clusterId,
    super.key, // ignore: unused_element_parameter
  });

  final ClusterID clusterId;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();

  late final PgUserBloc _pgUserBloc;

  var _pgUserName = '';
  var _password = '';
  String? _description;

  @override
  void initState() {
    _pgUserBloc = context.read<PgUserBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PgUserBloc, PgUserState>(
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case PgUserCreatedState(:final pgUser):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgPgUserCreated(pgUser.name)));
            context.read<PgUsersBloc>().add(PgUsersEvent.getUsers(GetPgUsersParams(clusterId: widget.clusterId)));
            context.pop();
          // case PgInstanceFailureState(:final message):
          //   messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: GeneralDialogLayout(
        constraints: BoxConstraints(maxWidth: 900),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: Spacing.s16,
            children: [
              Row(
                children: [
                  Icon(Icons.storage_rounded, size: 100),
                  SizedBox(width: 32),
                  SizedBox(
                    width: 500,
                    child: AppTextFormInput(
                      initialValue: _pgUserName,
                      helperText: context.$.pgUserNameHelperText,
                      onSaved: (value) => _pgUserName = value!,
                      validator: (value) => switch (value) {
                        _ when value!.isEmpty => context.$.requiredField,
                        _ => null,
                      },
                    ),
                  ),
                ],
              ),
              Divider(color: Palette.color1B1B1D),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columnWidth = (constraints.maxWidth - 3 * Spacing.s16) / 4;
                  return Column(
                    spacing: Spacing.s16,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth,
                        child: AppTextFormInput(
                          initialValue: _password,
                          helperText: context.$.password,
                          onSaved: (value) => _password = value!,
                          obscureText: true,
                          maxLines: 1,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                      ),
                      AppTextFormInput.description(
                        initialValue: _description,
                        helperText: context.$.description,
                        onSaved: (value) => _description = value!,
                      ),
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Spacer(),
                  SaveIconButton(onPressed: save),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final params = CreatePgUserParams(
        pgInstanceId: widget.clusterId,
        name: _pgUserName,
        password: _password,
        description: _description,
      );

      _pgUserBloc.add(PgUserEvent.create(params));
    }
  }
}

class CreatePgUserDialog extends StatelessWidget {
  const CreatePgUserDialog({required this.clusterID, super.key});

  final ClusterID clusterID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PgUserBloc(context.read<IPgUsersRepository>()),
      child: _View(clusterId: clusterID),
    );
  }
}
