import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instance_bloc/pg_instance_bloc.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_progress_indicator.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';

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

  // late List<String> _ipv4List;
  int _syncReplicaNumber = 1;

  @override
  void initState() {
    _pgInstanceBloc = context.read<PgInstanceBloc>();
    super.initState();
  }

  @override
  void dispose() {
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
            // _ipv4List = instance.ipv4;
            _syncReplicaNumber = instance.syncReplicaNumber;
          case PgInstanceUpdatedState():
            // messenger.showSnackBar(App)
          // case PgInstanceFailureState(:final message):
          //   scaffoldMessenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: BlocBuilder<PgInstanceBloc, PgInstanceState>(
        buildWhen: (_, current) => current is PgInstanceLoadingState || current is PgInstanceLoadedState,
        builder: (context, state) {
          if (state is! PgInstanceLoadedState) {
            return AppProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Breadcrumbs(
                  items: [
                    BreadcrumbItem(text: 'instance'.hardcoded),
                    BreadcrumbItem(text: context.$.create),
                  ],
                ),
                ButtonsBar(
                  children: [
                    SaveIconButton(onPressed: save),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SizedBox(
                      width: constraints.maxWidth * 0.4,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24,
                          children: [
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              initialValue: _name,
                              decoration: InputDecoration(hintText: context.$.name, helperText: context.$.name),
                              onSaved: (newValue) => _name = newValue!,
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              initialValue: _cores.toString(),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: 'cores'.hardcoded,
                                helperText: 'cores'.hardcoded,
                              ),
                              onSaved: (newValue) => _cores = int.parse(newValue!),
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              initialValue: _diskSize.toString(),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              // TODO(Koretsky): Проверить локализацию
                              decoration: InputDecoration(
                                hintText: context.$.rootDiskSize,
                                helperText: context.$.rootDiskSize,
                              ),
                              onSaved: (newValue) => _diskSize = int.parse(newValue!),
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              initialValue: _ram.toString(),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: 'ram'.hardcoded,
                                helperText: context.$.ramHelperText,
                              ),
                              onSaved: (newValue) => _ram = int.parse(newValue!),
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              initialValue: _nodesNumber.toString(),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: 'nodes number'.hardcoded,
                                helperText: 'nodes number'.hardcoded,
                              ),
                              onSaved: (newValue) => _nodesNumber = int.parse(newValue!),
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                            TextFormField(
                              autovalidateMode: AutovalidateMode.onUnfocus,
                              initialValue: _syncReplicaNumber.toString(),
                              decoration: InputDecoration(
                                hintText: 'sync replica number'.hardcoded,
                                helperText: 'sync replica number'.hardcoded,
                              ),
                              onSaved: (newValue) => _syncReplicaNumber = int.parse(newValue!),
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                            TextFormField(
                              initialValue: _description,
                              decoration: InputDecoration(
                                hintText: context.$.description,
                                helperText: context.$.description,
                              ),
                              onSaved: (newValue) => _description = newValue!,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // _pgInstanceBloc.add(
      //   // PgInstanceEvent.updateInstance(
      //   //   CreatePgInstanceParams(
      //   //     name: _name,
      //   //     description: _description,
      //   //     cores: _cores,
      //   //     ram: _ram,
      //   //     diskSize: _diskSize,
      //   //     nodesNumber: _nodesNumber,
      //   //     syncReplicaNumber: _syncReplicaNumber,
      //   //     // ipv4: _ipv4List,
      //   //   ),
      //   // ),
      // );
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
