import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/update_database_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/database_bloc/database_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/databases_selection_cubit/databases_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/widgets/pg_instance_status_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/form_card.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/id_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/metadata_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';

class _DatabaseView extends StatefulWidget {
  const _DatabaseView({
    required this.databaseId,
    required this.pgInstanceId,
    super.key, // ignore: unused_element_parameter,
  });

  final DatabaseID databaseId;
  final PgInstanceID pgInstanceId;

  @override
  State<_DatabaseView> createState() => _DatabaseViewState();
}

class _DatabaseViewState extends State<_DatabaseView> {
  final _formKey = GlobalKey<FormState>();

  late final DatabaseBloc _dbBloc;

  late String _dbName;
  String? _description;
  late String _instance;
  late String owner;

  @override
  void initState() {
    _dbBloc = context.read<DatabaseBloc>();
    // _pgUserBloc.add(PgUserEvent.startPolling(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    // _pgInstanceBloc.add(PgInstanceEvent.stopPolling());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gapWidth = 16.0;

    return BlocListener<DatabaseBloc, DatabaseState>(
      listenWhen: (_, current) => current is! DatabaseLoadingState,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case DatabaseLoadedState(:final database):
            _dbName = database.name;
            _instance = database.instance;
            _description = database.description;

          case DatabaseUpdatedState(:final database):
            messenger.showSnackBar(AppSnackBar.success(context.$.success));
          // context.read<DatabasesBloc>().add(
          //   DatabasesEvent.getDatabases(GetDatabasesParams(instanceId: widget.pgInstanceId)),
          // );
          //
          // case PgUserDeletedState(:final pgUser):
          //   messenger.showSnackBar(AppSnackBar.success(context.$.success));
          //   context.read<PgInstancesBloc>().add(PgInstancesEvent.getInstances());
          //   context.pop();
          default:
        }
      },
      child: BlocBuilder<DatabaseBloc, DatabaseState>(
        buildWhen: (_, current) => current is DatabaseLoadingState || current is DatabaseLoadedState,
        builder: (context, state) {
          if (state is! DatabaseLoadedState) {
            return AppProgressIndicator();
          }
          final DatabaseLoadedState(:database) = state;
          return Form(
            key: _formKey,
            child: PageLayout(
              breadcrumbs: [
                BreadcrumbItem(text: context.$.pgCluster),
                BreadcrumbItem(text: database.name),
              ],
              buttons: [
                // _DeletePgInstanceButton(instance: instance),
                SaveIconButton(onPressed: save),
              ],
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: gapWidth,
                    children: [
                      FormCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.storage_rounded, size: 100),
                            SizedBox(width: 32),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: gapWidth,
                              children: [
                                IdWidget(id: database.id.raw),
                                SizedBox(
                                  width: 500,
                                  child: AppTextFormInput(
                                    initialValue: _dbName,
                                    helperText: 'Database name'.hardcoded,
                                    onSaved: (value) => _dbName = value!,
                                    validator: (value) => switch (value) {
                                      _ when value!.isEmpty => context.$.requiredField,
                                      _ => null,
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            MetadataTable(
                              statusWidget: PgInstanceStatusWidget(status: PgInstanceStatus.active),
                              createdAt: database.createdAt,
                              updatedAt: database.updatedAt,
                            ),
                          ],
                        ),
                      ),
                      FormCard(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final columnWidth = (constraints.maxWidth - 3 * gapWidth) / 4;
                            return Column(
                              spacing: gapWidth,
                              children: [
                                Row(
                                  spacing: gapWidth,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth,
                                      child: AppTextFormInput(
                                        initialValue: _instance,
                                        helperText: 'Instance'.hardcoded,
                                        onSaved: (value) => _instance = value!,
                                        validator: (value) => switch (value) {
                                          _ when value!.isEmpty => context.$.requiredField,
                                          _ => null,
                                        },
                                      ),
                                    ),
                                  ],
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final params = UpdateDatabaseParams(
        pgInstanceId: widget.pgInstanceId,
        databaseId: widget.databaseId,
        description: _description,
        name: _dbName,
        // owner: '',
      );
      _dbBloc.add(DatabaseEvent.update(params));
    }
  }
}

class DatabasePage extends StatelessWidget {
  const DatabasePage({
    required this.databaseId,
    required this.pgInstanceId,
    super.key,
  });

  final PgInstanceID pgInstanceId;
  final DatabaseID databaseId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DatabaseBloc(
            context.read<IDatabaseRepository>(),
          )..add(DatabaseEvent.get(DatabaseParams(databaseId: databaseId, instanceId: pgInstanceId))),
        ),
        BlocProvider(
          create: (context) => DatabasesSelectionCubit(),
        ),
      ],
      child: _DatabaseView(databaseId: databaseId, pgInstanceId: pgInstanceId),
    );
  }
}
