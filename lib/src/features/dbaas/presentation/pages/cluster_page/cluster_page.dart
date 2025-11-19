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
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/cluster_status_widget.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/create_pg_user_dialog.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/widgets/pg_user_table.dart';
import 'package:genesis/src/routing/app_router.dart';
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

class _ViewState extends State<_View> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    clusterObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  // Экран стал видимым (вернулись назад / сняли перекрытие)
  @override
  void didPopNext() {
    context.read<PgUsersBloc>().add(PgUsersEvent.getUsers(GetPgUsersParams(clusterId: widget.clusterId)));
    // context.read<ClusterBloc>().add(ClusterEvent.startPolling(widget.clusterId));
  }

  // Поверх запушили другой экран — можно приостановить
  @override
  void didPushNext() {
    context.read<ClusterBloc>().add(ClusterEvent.stopPolling());
  }

  @override
  void dispose() {
    clusterObserver.unsubscribe(this);
    context.read<ClustersBloc>().add(ClustersEvent.stopPolling());
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  late final ClusterBloc _clusterBloc;

  late Cluster _cluster;

  @override
  void initState() {
    _clusterBloc = context.read<ClusterBloc>();
    super.initState();
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
                _cluster = instance;
              // _clusterName = instance.name;
              // _description = instance.description;
              // _cores = instance.cores;
              // _ram = instance.ram;
              // _diskSize = instance.diskSize;
              // _nodesNumber = instance.nodesNumber;
              // _ipsv4List = instance.ipsv4;
              // _syncReplicaNumber = instance.syncReplicaNumber;
              // _versionLink = instance.version;

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
        buildWhen: (previous, current) {
          return previous != current;
        },
        builder: (context, state) {
          if (state is! ClusterLoadedState) {
            return AppProgressIndicator();
          }
          final ClusterLoadedState(:cluster) = state;

          return PageLayout(
            breadcrumbs: [
              BreadcrumbItem(text: context.$.clusters),
              BreadcrumbItem(text: cluster.name),
            ],
            buttons: [
              _DeleteClusterButton(instance: cluster),
              SaveIconButton(onPressed: save),
            ],
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
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
                              IdWidget(id: cluster.id.raw),
                              SizedBox(
                                width: 500,
                                child: AppTextFormInput(
                                  initialValue: _cluster.name,
                                  helperText: context.$.clusterNameHelperText,
                                  onSaved: (newValue) => _cluster = _cluster.copyWith(name: newValue),
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
                            statusWidget: ClusterStatusWidget(status: cluster.status),
                            createdAt: cluster.createdAt,
                            updatedAt: cluster.updatedAt,
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
                                      initialValue: _cluster.cores.toString(),
                                      helperText: context.$.cores,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      onSaved: (newValue) => _cluster = _cluster.copyWith(cores: int.parse(newValue!)),
                                      validator: (value) => switch (value) {
                                        _ when value!.isEmpty => context.$.requiredField,
                                        _ => null,
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: columnWidth,
                                    child: AppTextFormInput(
                                      initialValue: _cluster.diskSize.toString(),
                                      helperText: context.$.diskSize,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      // TODO(Koretsky): Проверить локализацию
                                      onSaved: (newValue) =>
                                          _cluster = _cluster.copyWith(diskSize: int.parse(newValue!)),
                                      validator: (value) => switch (value) {
                                        _ when value!.isEmpty => context.$.requiredField,
                                        _ => null,
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: columnWidth,
                                    child: AppTextFormInput(
                                      initialValue: _cluster.nodesNumber.toString(),
                                      helperText: context.$.nodeCountHelperText,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      onSaved: (newValue) =>
                                          _cluster = _cluster.copyWith(nodesNumber: int.parse(newValue!)),
                                      validator: (value) => switch (value) {
                                        _ when value!.isEmpty => context.$.requiredField,
                                        _ => null,
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: columnWidth,
                                    child: AppTextFormInput(
                                      initialValue: _cluster.syncReplicaNumber.toString(),
                                      helperText: 'Sync replica number'.hardcoded,
                                      onSaved: (newValue) => _cluster = _cluster.copyWith(
                                        syncReplicaNumber: int.parse(newValue!),
                                      ),
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
                                      initialValue: _cluster.ram.toString(),
                                      helperText: context.$.ramLabelText,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      onSaved: (newValue) => _cluster = _cluster.copyWith(
                                        ram: int.parse(newValue!),
                                      ),
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
                                      initialValue: _cluster.ipsv4.join(', '),
                                      helperText: 'Ipsv4'.hardcoded,
                                      maxLines: 3,
                                      minLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              AppTextFormInput(
                                initialValue: _cluster.version,
                                helperText: context.$.versionHelperText,
                                onSaved: (newValue) => _cluster = _cluster.copyWith(
                                  version: newValue!,
                                ),
                                validator: (value) => switch (value) {
                                  _ when value!.isEmpty => context.$.requiredField,
                                  _ => null,
                                },
                              ),
                              AppTextFormInput.description(
                                initialValue: _cluster.description,
                                helperText: context.$.description,
                                onSaved: (newValue) => _cluster = _cluster.copyWith(
                                  description: newValue,
                                ),
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
                      child: BlocConsumer<PgUsersBloc, PgUsersState>(
                        listenWhen: (_, current) => current is PgUsersDeletedState,
                        listener: (context, state) {
                          context.read<PgUsersSelectionCubit>().onClear();
                        },
                        buildWhen: (_, current) => current is PgUsersLoadingState || current is PgUsersLoadedState,
                        builder: (context, state) {
                          return switch (state) {
                            _ when state is! PgUsersLoadedState => AppProgressIndicator(),
                            _ => PgUsersTable(pgUsers: state.pgUsers),
                          };
                        },
                      ),
                    ),
                  ],
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
        name: _cluster.name,
        description: _cluster.description,
        cores: _cluster.cores,
        ram: _cluster.ram,
        diskSize: _cluster.diskSize,
        nodesNumber: _cluster.nodesNumber,
        syncReplicaNumber: _cluster.syncReplicaNumber,
        // ipv4: _ipv4List,
      );
      _clusterBloc.add(ClusterEvent.update(params));
    }
  }
}

class ClusterPage extends StatelessWidget {
  const ClusterPage({
    required this.clusterId,
    super.key,
  });

  final ClusterID clusterId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final repository = context.read<IClustersRepository>();
            return ClusterBloc(repository)..add(ClusterEvent.startPolling(clusterId));
          },
        ),
        BlocProvider(
          create: (context) {
            final repository = context.read<IPgUsersRepository>();
            final params = GetPgUsersParams(clusterId: clusterId);
            return PgUsersBloc(repository)..add(PgUsersEvent.getUsers(params));
          },
        ),
        BlocProvider(
          create: (context) => PgUsersSelectionCubit(),
        ),
      ],
      child: _View(clusterId: clusterId),
    );
  }
}
