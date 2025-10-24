import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/update_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instance_bloc/pg_instance_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/widgets/pg_instance_status_widget.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/form_card.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

part './widgets/delete_pg_instance_btn.dart';

class _PgInstanceDetailsPage extends StatefulWidget {
  const _PgInstanceDetailsPage({
    required this.id,
    super.key, // ignore: unused_element_parameter
  });

  final PgInstanceID id;

  @override
  State<_PgInstanceDetailsPage> createState() => __PgInstanceDetailsPageState();
}

class __PgInstanceDetailsPageState extends State<_PgInstanceDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  late final PgInstanceBloc _pgInstanceBloc;

  late String _name;
  String? _description;
  late int _cores;
  late int _ram;
  late int _diskSize;
  late int _nodesNumber;
  late List<String> _ipsv4List;
  late int _syncReplicaNumber;
  late String _version;

  @override
  void initState() {
    _pgInstanceBloc = context.read<PgInstanceBloc>();
    _pgInstanceBloc.add(PgInstanceEvent.startPolling(widget.id));
    super.initState();
  }

  @override
  void dispose() {
    _pgInstanceBloc.add(PgInstanceEvent.stopPolling());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PgInstanceBloc, PgInstanceState>(
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        switch (state) {
          case PgInstanceLoadedState(:final instance):
            _name = instance.name;
            _description = instance.description;
            _cores = instance.cores;
            _ram = instance.ram;
            _diskSize = instance.diskSize;
            _nodesNumber = instance.nodesNumber;
            _ipsv4List = instance.ipsv4;
            _syncReplicaNumber = instance.syncReplicaNumber;
            _version = instance.version;
          case PgInstanceUpdatedState(:final instance):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterUpdated(instance.name)));
            context.read<PgInstancesBloc>().add(PgInstancesEvent.getInstances());

          case PgInstanceDeletedState(:final instance):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterDeleted(instance.name)));
            context.read<PgInstancesBloc>().add(PgInstancesEvent.getInstances());
            context.pop();
          default:
        }
      },
      child: BlocBuilder<PgInstanceBloc, PgInstanceState>(
        buildWhen: (_, current) => current is PgInstanceLoadingState || current is PgInstanceLoadedState,
        builder: (context, state) {
          if (state is! PgInstanceLoadedState) {
            return AppProgressIndicator();
          }
          final PgInstanceLoadedState(:instance) = state;
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: PageLayout(
                breadcrumbs: Breadcrumbs(
                  items: [
                    BreadcrumbItem(text: context.$.pgCluster),
                    BreadcrumbItem(text: context.$.create),
                  ],
                ),
                buttonsBar: ButtonsBar(
                  children: [
                    _DeletePgInstanceButton(instance: instance),
                    SaveIconButton(onPressed: save),
                  ],
                ),
                children: [
                  FormCard(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.storage_rounded, size: 100),
                            SizedBox(width: 32),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16.0,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'ID: ',
                                    children: [
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: SelectableText(
                                          instance.id.raw,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: GoogleFonts.robotoMono().fontFamily,
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(child: const SizedBox(width: 8)),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: IconButton(
                                          icon: Icon(Icons.copy, color: Colors.white, size: 18),
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(text: instance.id.raw));
                                            final msg = context.$.msgCopiedToClipboard(instance.id.raw);
                                            ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.success(msg));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 500,
                                  child: AppTextFormInput(
                                    initialValue: _name,
                                    helperText: context.$.username,
                                    onSaved: (newValue) => _name = newValue!,
                                    validator: (value) => switch (value) {
                                      _ when value!.isEmpty => context.$.requiredField,
                                      _ => null,
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Table(
                              defaultColumnWidth: FixedColumnWidth(140),
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(context.$.status),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PgInstanceStatusWidget(status: instance.status),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(context.$.createdAt),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(DateFormat('dd.MM.yyyy HH:mm').format(instance.createdAt)),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(context.$.updatedAt),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(DateFormat('dd.MM.yyyy HH:mm').format(instance.updatedAt)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FormCard(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const gapWidth = 16.0;
                        final columnWidth = (constraints.maxWidth - 3 * gapWidth) / 4;
                        return Column(
                          spacing: gapWidth,
                          children: [
                            Row(
                              spacing: 16.0,
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
                                    helperText: context.$.rootDiskSize,
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
                                    helperText: 'Nodes number'.hardcoded,
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
                                    helperText: 'sync replica number'.hardcoded,
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
                                    helperText: context.$.ramHelperText,
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
                              initialValue: _version,
                              helperText: 'Version'.hardcoded,
                              onSaved: (newValue) => _version = newValue!,
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
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
      final params = UpdatePgInstanceParams(
        id: widget.id,
        name: _name,
        description: _description,
        cores: _cores,
        ram: _ram,
        ipsv4: null,
        diskSize: _diskSize,
        nodesNumber: _nodesNumber,
        syncReplicaNumber: _syncReplicaNumber,
        // ipv4: _ipv4List,
      );
      _pgInstanceBloc.add(PgInstanceEvent.updateInstance(params));
    }
  }
}

class PgInstanceDetailsPage extends StatelessWidget {
  const PgInstanceDetailsPage({required this.id, super.key});

  final PgInstanceID id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PgInstanceBloc(
        context.read<IPgInstancesRepository>(),
      )..add(PgInstanceEvent.getInstance(id)),
      child: _PgInstanceDetailsPage(id: id),
    );
  }
}
