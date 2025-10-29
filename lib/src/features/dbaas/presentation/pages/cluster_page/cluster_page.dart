import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/update_cluster_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/cluster_bloc/cluster_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_users_bloc/pg_users_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_users_selection_cubit/pg_users_selection_cubit.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/create_pg_user_dialog.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/pg_user_table.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/cluster_status_widget.dart';
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

part './widgets/create_pg_user_btn.dart';

part './widgets/delete_cluster_btn.dart';

part './widgets/delete_pg_users_btn.dart';

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

  late final ClusterBloc _clusterBloc;

  late String _clusterName;
  String? _description;
  late int _cores;
  late int _ram;
  late int _diskSize;
  late int _nodesNumber;
  late List<String> _ipsv4List;
  late int _syncReplicaNumber;
  late String _versionLink;

  @override
  void initState() {
    _clusterBloc = context.read<ClusterBloc>();
    _clusterBloc.add(ClusterEvent.startPolling(widget.clusterId));
    super.initState();
  }

  @override
  void dispose() {
    _clusterBloc.add(ClusterEvent.stopPolling());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ClusterBloc, ClusterState>(
          listenWhen: (_, current) => current.shouldListen,
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);

            switch (state) {
              case ClusterLoadedState(cluster: final instance):
                _clusterName = instance.name;
                _description = instance.description;
                _cores = instance.cores;
                _ram = instance.ram;
                _diskSize = instance.diskSize;
                _nodesNumber = instance.nodesNumber;
                _ipsv4List = instance.ipsv4;
                _syncReplicaNumber = instance.syncReplicaNumber;
                _versionLink = instance.version;

              case ClusterUpdatedState(cluster: final instance):
                messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterUpdated(instance.name)));
                context.read<ClustersBloc>().add(ClustersEvent.getClusters());

              case ClusterDeletedState(cluster: final instance):
                messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterDeleted(instance.name)));
                context.read<ClustersBloc>().add(ClustersEvent.getClusters());
                context.pop();

              default:
            }
          },
        ),
      ],
      child: BlocBuilder<ClusterBloc, ClusterState>(
        buildWhen: (_, current) => current is ClusterLoadingState || current is ClusterLoadedState,
        builder: (context, state) {
          if (state is! ClusterLoadedState) {
            return AppProgressIndicator();
          }
          final ClusterLoadedState(cluster: instance) = state;

          return Form(
            key: _formKey,
            child: PageLayout(
              breadcrumbs: [
                BreadcrumbItem(text: context.$.clusters),
                BreadcrumbItem(text: instance.name),
              ],
              buttons: [
                _DeleteClusterButton(instance: instance),
                SaveIconButton(onPressed: save),
              ],
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                IdWidget(id: instance.id.raw),
                                SizedBox(
                                  width: 500,
                                  child: AppTextFormInput(
                                    initialValue: _clusterName,
                                    helperText: context.$.clusterNameHelperText,
                                    onSaved: (newValue) => _clusterName = newValue!,
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
                              statusWidget: ClusterStatusWidget(status: instance.status),
                              createdAt: instance.createdAt,
                              updatedAt: instance.updatedAt,
                            ),
                          ],
                        ),
                      ),
                      FormCard(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final columnWidth = (constraints.maxWidth - 3 * Spacing.s16) / 4;
                            return Column(
                              spacing: Spacing.s16,
                              children: [
                                Row(
                                  spacing: Spacing.s16,
                                  children: [
                                    SizedBox(
                                      width: columnWidth,
                                      child: AppTextFormInput(
                                        initialValue: _cores.toString(),
                                        helperText: context.$.cores,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        onSaved: (newValue) => _cores = int.parse(newValue!),
                                        validator: (value) => switch (value) {
                                          _ when value!.isEmpty => context.$.requiredField,
                                          _ => null,
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: columnWidth,
                                      child: AppTextFormInput(
                                        initialValue: _diskSize.toString(),
                                        helperText: context.$.diskSize,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        // TODO(Koretsky): Проверить локализацию
                                        onSaved: (newValue) => _diskSize = int.parse(newValue!),
                                        validator: (value) => switch (value) {
                                          _ when value!.isEmpty => context.$.requiredField,
                                          _ => null,
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: columnWidth,
                                      child: AppTextFormInput(
                                        initialValue: _nodesNumber.toString(),
                                        helperText: context.$.nodeCountHelperText,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        onSaved: (newValue) => _nodesNumber = int.parse(newValue!),
                                        validator: (value) => switch (value) {
                                          _ when value!.isEmpty => context.$.requiredField,
                                          _ => null,
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: columnWidth,
                                      child: AppTextFormInput(
                                        initialValue: _syncReplicaNumber.toString(),
                                        helperText: 'Sync replica number'.hardcoded,
                                        onSaved: (newValue) => _syncReplicaNumber = int.parse(newValue!),
                                        validator: (value) => switch (value) {
                                          _ when value!.isEmpty => context.$.requiredField,
                                          _ => null,
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: Spacing.s16,
                                  children: [
                                    SizedBox(
                                      width: columnWidth,
                                      child: AppTextFormInput(
                                        initialValue: _ram.toString(),
                                        helperText: context.$.ramLabelText,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        onSaved: (newValue) => _ram = int.parse(newValue!),
                                        validator: (value) => switch (value) {
                                          _ when value!.isEmpty => context.$.requiredField,
                                          _ => null,
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: (columnWidth * 3) + (Spacing.s16 * 2),
                                      child: AppTextFormInput(
                                        readOnly: true,
                                        initialValue: _ipsv4List.join(', '),
                                        helperText: 'Ipsv4'.hardcoded,
                                        maxLines: 3,
                                        minLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                AppTextFormInput(
                                  initialValue: _versionLink,
                                  helperText: context.$.versionHelperText,
                                  onSaved: (newValue) => _versionLink = newValue!,
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                                AppTextFormInput.description(
                                  initialValue: _description,
                                  helperText: context.$.description,
                                  onSaved: (newValue) => _description = newValue!,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Row(
                        spacing: Spacing.s4,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _DeletePgUsersButton(clusterId: widget.clusterId),
                          _CreatePgUserButton(id: widget.clusterId),
                        ],
                      ),
                      SizedBox(
                        height: 400,
                        child: BlocBuilder<PgUsersBloc, PgUsersState>(
                          builder: (context, state) {
                            if (state is! PgUsersLoadedState) {
                              return AppProgressIndicator();
                            }
                            return PgUsersTable(pgUsers: state.pgUsers);
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
      final params = UpdateClusterParams(
        id: widget.clusterId,
        name: _clusterName,
        description: _description,
        cores: _cores,
        ram: _ram,
        ipsv4: null,
        diskSize: _diskSize,
        nodesNumber: _nodesNumber,
        syncReplicaNumber: _syncReplicaNumber,
        // ipv4: _ipv4List,
      );
      _clusterBloc.add(ClusterEvent.update(params));
    }
  }
}

class ClusterPage extends StatelessWidget {
  const ClusterPage({
    required this.id,
    super.key,
  });

  final ClusterID id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository = context.read<IClustersRepository>();
            return ClusterBloc(repository)..add(ClusterEvent.get(id));
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = context.read<IPgUsersRepository>();
            final params = GetPgUsersParams(clusterId: id);
            return PgUsersBloc(repository)..add(PgUsersEvent.getUsers(params));
          },
        ),
        BlocProvider(
          create: (context) => PgUsersSelectionCubit(),
        ),
      ],
      child: _View(clusterId: id),
    );
  }
}
