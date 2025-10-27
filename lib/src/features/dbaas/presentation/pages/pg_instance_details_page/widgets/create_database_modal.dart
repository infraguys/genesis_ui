import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/create_database_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_instances/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/databases_bloc/databases_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instance_bloc/pg_instance_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreateDatabaseDialogView extends StatefulWidget {
  const _CreateDatabaseDialogView({required this.instanceId, super.key});

  final PgInstanceID instanceId; // ignore: unused_element_parameter

  @override
  State<_CreateDatabaseDialogView> createState() => _CreateDatabaseDialogViewState();
}

class _CreateDatabaseDialogViewState extends State<_CreateDatabaseDialogView> {
  final _formKey = GlobalKey<FormState>();

  late final DatabasesBloc _databasesBloc;

  var _dbName = '';
  var _owner = 'postgres';
  String? _description;

  @override
  void initState() {
    _databasesBloc = context.read<DatabasesBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gapWidth = 16.0;

    return BlocListener<DatabasesBloc, DatabasesState>(
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case DatabasesCreatedState(:final database):
            messenger.showSnackBar(AppSnackBar.success(context.$.success));
            context.read<PgInstancesBloc>().add(PgInstancesEvent.getInstances());
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
            spacing: gapWidth,
            children: [
              Row(
                children: [
                  Icon(Icons.storage_rounded, size: 100),
                  SizedBox(width: 32),
                  SizedBox(
                    width: 500,
                    child: AppTextFormInput(
                      initialValue: _dbName,
                      helperText: 'Database name'.hardcoded,
                      onSaved: (newValue) => _dbName = newValue!,
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
                  final columnWidth = (constraints.maxWidth - 3 * gapWidth) / 4;
                  return Column(
                    spacing: gapWidth,
                    children: [
                      Row(
                        spacing: gapWidth,
                        children: [
                          SizedBox(
                            width: columnWidth,
                            child: AppTextFormInput(
                              initialValue: _owner,
                              helperText: 'Owner'.hardcoded,
                              onSaved: (newValue) => _owner = newValue!,
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                          ),
                        ],
                      ),
                      AppTextFormInput(
                        initialValue: _description,
                        helperText: context.$.description,
                        maxLines: 2,
                        minLines: 2,
                        onSaved: (newValue) => _description = newValue!,
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
      final params = CreateDatabaseParams(
        instanceId: widget.instanceId,
        name: _dbName,
        owner: 'postgres'.hardcoded,
        description: _description,
      );

      _databasesBloc.add(DatabasesEvent.createDatabase(params));
    }
  }
}

class CreateDatabaseDialog extends StatelessWidget {
  const CreateDatabaseDialog({required this.instanceID, super.key});

  final PgInstanceID instanceID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PgInstanceBloc(context.read<IPgInstancesRepository>()),
      child: _CreateDatabaseDialogView(
        instanceId: instanceID,
      ),
    );
  }
}
