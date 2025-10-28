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
import 'package:genesis/src/features/dbaas/presentation/pages/pg_instance_details_page/widgets/create_pg_user_dialog.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_instance_details_page/widgets/pg_user_table.dart';
import 'package:genesis/src/features/dbaas/presentation/widgets/cluster_status_widget.dart';
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

part './widgets/delete_pg_instance_btn.dart';

class _PgInstanceDetailsView extends StatefulWidget {
  const _PgInstanceDetailsView({
    required this.id,
    super.key, // ignore: unused_element_parameter
  });

  final ClusterID id;

  @override
  State<_PgInstanceDetailsView> createState() => _PgInstanceDetailsViewState();
}

class _PgInstanceDetailsViewState extends State<_PgInstanceDetailsView> {
  final _formKey = GlobalKey<FormState>();

  late final ClusterBloc _pgInstanceBloc;

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
    _pgInstanceBloc = context.read<ClusterBloc>();
    _pgInstanceBloc.add(ClusterEvent.startPolling(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _pgInstanceBloc.add(ClusterEvent.stopPolling());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gapWidth = 16.0;

    return BlocListener<ClusterBloc, ClusterState>(
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        switch (state) {
          case ClusterLoadedState(cluster:final instance):
            _clusterName = instance.name;
            _description = instance.description;
            _cores = instance.cores;
            _ram = instance.ram;
            _diskSize = instance.diskSize;
            _nodesNumber = instance.nodesNumber;
            _ipsv4List = instance.ipsv4;
            _syncReplicaNumber = instance.syncReplicaNumber;
            _versionLink = instance.version;
          case ClusterUpdatedState(cluster:final instance):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterUpdated(instance.name)));
            context.read<ClustersBloc>().add(ClustersEvent.getClusters());

          case ClusterDeletedState(cluster:final instance):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterDeleted(instance.name)));
            context.read<ClustersBloc>().add(ClustersEvent.getClusters());
            context.pop();
          default:
        }
      },
      child: BlocBuilder<ClusterBloc, ClusterState>(
        buildWhen: (_, current) => current is ClusterLoadingState || current is ClusterLoadedState,
        builder: (context, state) {
          if (state is! ClusterLoadedState) {
            return AppProgressIndicator();
          }
          final ClusterLoadedState(cluster:instance) = state;
          return Form(
            key: _formKey,
            child: PageLayout(
              breadcrumbs: [
                BreadcrumbItem(text: context.$.clusters),
                BreadcrumbItem(text: instance.name),
              ],
              buttons: [
                _DeletePgInstanceButton(instance: instance),
                SaveIconButton(onPressed: save),
                SizedBox(width: 16),
                CreateIconButton(
                  label: 'Create PG user'.hardcoded,
                  onPressed: () async {
                    await showDialog<PgUser>(
                      context: context,
                      builder: (context) => Dialog(child: CreatePgUserDialog(instanceID: widget.id)),
                    );
                  },
                ),
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
                                  spacing: gapWidth,
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
                                      width: (columnWidth * 3) + (gapWidth * 2),
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
        id: widget.id,
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
      _pgInstanceBloc.add(ClusterEvent.update(params));
    }
  }
}

class PgInstanceDetailsPage extends StatelessWidget {
  const PgInstanceDetailsPage({required this.id, super.key});

  final ClusterID id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClusterBloc(
            context.read<IClustersRepository>(),
          )..add(ClusterEvent.get(id)),
          child: _PgInstanceDetailsView(id: id),
        ),
        BlocProvider(
          create: (context) => PgUsersBloc(context.read<IPgUsersRepository>())
            ..add(
              PgUsersEvent.getPgUsers(GetPgUsersParams(pgInstanceId: id)),
            ),
        ),
      ],
      child: _PgInstanceDetailsView(id: id),
    );
  }
}
