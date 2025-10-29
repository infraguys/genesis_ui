import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/create_database_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/get_databases_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/database_bloc/database_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/databases_bloc/databases_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _View extends StatefulWidget {
  const _View({
    required this.clusterId,
    required this.pgUserId,
    super.key, // ignore: unused_element_parameter
  });

  final ClusterID clusterId;
  final PgUserID pgUserId;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();

  late final DatabaseBloc _databaseBloc;

  var _dbName = '';
  String? _description;

  @override
  void initState() {
    _databaseBloc = context.read<DatabaseBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gapWidth = 16.0;

    return BlocListener<DatabaseBloc, DatabaseState>(
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case DatabaseCreatedState(:final database):
            messenger.showSnackBar(AppSnackBar.success(context.$.success));
            context.read<DatabasesBloc>().add(
              DatabasesEvent.getDatabases(
                GetDatabasesParams(clusterId: widget.clusterId),
              ),
            );
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
                      // Row(
                      //   spacing: gapWidth,
                      //   children: [
                      //     // SizedBox(
                      //     //   width: columnWidth,
                      //     //   child: AppTextFormInput(
                      //     //     initialValue: Env.,
                      //     //     helperText: 'Owner'.hardcoded,
                      //     //     onSaved: (newValue) => _owner = newValue!,
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
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
        instanceId: widget.clusterId,
        name: _dbName,
        pgUserId: widget.pgUserId,
        description: _description,
      );

      _databaseBloc.add(DatabaseEvent.create(params));
    }
  }
}

class CreateDatabaseDialog extends StatelessWidget {
  const CreateDatabaseDialog({
    required this.clusterId,
    required this.pgUserId,
    super.key,
  });

  final ClusterID clusterId;
  final PgUserID pgUserId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseBloc(context.read<IDatabaseRepository>()),
      child: _View(
        clusterId: clusterId,
        pgUserId: pgUserId,
      ),
    );
  }
}
