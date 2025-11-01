import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/update_pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/databases_bloc/databases_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/databases_selection_cubit/databases_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_user_bloc/pg_user_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/pg_user_status_widget.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_user_page/widget/create_database_dialog.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_user_page/widget/database_table.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/create_icon_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/form_card.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/id_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/metadata_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

part './widget/create_db_btn.dart';
part './widget/delete_databases_btn.dart';

class _View extends StatefulWidget {
  const _View({
    required this.pgUserId,
    required this.clusterId,
    super.key, // ignore: unused_element_parameter,
  });

  final PgUserID pgUserId;
  final ClusterID clusterId;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();

  late final PgUserBloc _pgUserBloc;

  late String _pgUserName;
  String? _description;
  late String _password;
  late String _instance;

  @override
  void initState() {
    _pgUserBloc = context.read<PgUserBloc>();
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
    return MultiBlocListener(
      listeners: [
        BlocListener<PgUserBloc, PgUserState>(
          listenWhen: (_, current) => current is! PgUserLoadingState,
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);
            switch (state) {
              case PgUserLoadedState(:final pgUser):
                _pgUserName = pgUser.name;
                _password = pgUser.password;
                _instance = pgUser.instance;
                _description = pgUser.description;

              case PgUserUpdatedState(:final pgUser):
                messenger.showSnackBar(AppSnackBar.success(context.$.success));
                context.read<ClustersBloc>().add(ClustersEvent.getClusters());

              case PgUserDeletedState(:final pgUser):
                messenger.showSnackBar(AppSnackBar.success(context.$.success));
                context.read<ClustersBloc>().add(ClustersEvent.getClusters());
                context.pop();
              default:
            }
          },
        ),
      ],
      child: BlocBuilder<PgUserBloc, PgUserState>(
        buildWhen: (_, current) => current is PgUserLoadingState || current is PgUserLoadedState,
        builder: (context, state) {
          if (state is! PgUserLoadedState) {
            return AppProgressIndicator();
          }
          final PgUserLoadedState(:pgUser) = state;
          return PageLayout(
            breadcrumbs: [
              BreadcrumbItem(text: context.$.clusters),
              BreadcrumbItem(text: widget.clusterId.raw),
              BreadcrumbItem(text: pgUser.name),
            ],
            buttons: [
              // _DeletePgInstanceButton(instance: instance),
              SaveIconButton(onPressed: save),
            ],
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Spacing.s16,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      spacing: Spacing.s16,
                      children: [
                        FormCard(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.storage_rounded, size: 100),
                              SizedBox(width: 32),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: Spacing.s16,
                                children: [
                                  IdWidget(id: pgUser.id.raw),
                                  SizedBox(
                                    width: 500,
                                    child: AppTextFormInput(
                                      initialValue: _pgUserName,
                                      helperText: context.$.pgUsernameHelperText,
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              MetadataTable(
                                statusWidget: PgUserStatusWidget(status: pgUser.status),
                                createdAt: pgUser.createdAt,
                                updatedAt: pgUser.updatedAt,
                              ),
                            ],
                          ),
                        ),
                        FormCard(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              const gapWidth = Spacing.s16;
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
                                          initialValue: _password,
                                          helperText: context.$.password,
                                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                          onSaved: (value) => _password = value!,
                                          obscureText: true,
                                          maxLines: 1,
                                          validator: (value) => switch (value) {
                                            _ when value!.isEmpty => context.$.requiredField,
                                            _ => null,
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: (columnWidth * 3) + (gapWidth * 2),
                                        child: AppTextFormInput(
                                          initialValue: _instance,
                                          helperText: context.$.clusterLinkHelperText,
                                          // TODO(Koretsky): Проверить локализацию
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: Spacing.s4,
                    children: [
                      _DeleteDatabasesButton(clusterId: widget.clusterId),
                      _CreateDbButton(clusterId: widget.clusterId, pgUserId: widget.pgUserId),
                    ],
                  ),
                  SizedBox(
                    height: 400,
                    child: BlocConsumer<DatabasesBloc, DatabasesState>(
                      listenWhen: (_, current) => current is DatabasesDeletedState,
                      listener: (context, state) => context.read<DatabasesSelectionCubit>().onClear(),
                      builder: (_, state) {
                        return switch (state) {
                          _ when state is! DatabasesLoadedState => AppProgressIndicator(),
                          _ => DatabaseTable(databases: state.databases),
                        };
                      },
                    ),
                  ),
                ],
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
      final params = UpdatePgUserParams(
        pgInstanceId: widget.clusterId,
        pgUserId: widget.pgUserId,
        description: _description,
      );
      _pgUserBloc.add(PgUserEvent.update(params));
    }
  }
}

class PgUserPage extends StatelessWidget {
  const PgUserPage({
    required this.pgUserId,
    required this.clusterId,
    super.key,
  });

  final PgUserID pgUserId;
  final ClusterID clusterId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PgUserBloc(context.read<IPgUsersRepository>())
            ..add(
              PgUserEvent.get(
                PgUserParams(clusterId: clusterId, pgUserId: pgUserId),
              ),
            ),
        ),
        BlocProvider(
          create: (context) {
            return DatabasesBloc(context.read<IDatabaseRepository>())..add(DatabasesEvent.startPolling(clusterId));

            //   ..add(
            //   DatabasesEvent.getDatabases(GetDatabasesParams(clusterId: clusterId)),
            // );
          },
        ),
        BlocProvider(
          create: (context) => DatabasesSelectionCubit(),
        ),
      ],
      child: _View(pgUserId: pgUserId, clusterId: clusterId),
    );
  }
}
