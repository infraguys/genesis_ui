import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instance_bloc/pg_instance_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreatePgInstanceView extends StatefulWidget {
  const _CreatePgInstanceView({super.key}); // ignore: unused_element_parameter

  @override
  State<_CreatePgInstanceView> createState() => _CreatePgInstanceViewState();
}

class _CreatePgInstanceViewState extends State<_CreatePgInstanceView> {
  final _formKey = GlobalKey<FormState>();

  late final PgInstanceBloc _pgInstanceBloc;

  var _name = '';
  String? _description;
  var _cores = 1;
  var _ram = 512;
  var _diskSize = 10;
  var _nodesNumber = 1;
  var _ipv4List = <String>[];
  var _syncReplicaNumber = 1;

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
          case PgInstanceCreatedState(:final instance):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgClusterCreated(instance.name)));
            context.read<PgInstancesBloc>().add(PgInstancesEvent.getInstances());
            context.pop();
          case PgInstanceFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: SingleChildScrollView(
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
                      spacing: 16,
                      children: [
                        TextFormField(
                          initialValue: _name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: context.$.name,
                            helperText: ''
                          ),
                          onSaved: (newValue) => _name = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          initialValue: _cores.toString(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            labelText: 'cores'.hardcoded,
                            helperText: '',
                          ),
                          onSaved: (newValue) => _cores = int.parse(newValue!),
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          initialValue: _diskSize.toString(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          // TODO(Koretsky): Проверить локализацию
                          decoration: InputDecoration(
                            labelText: context.$.rootDiskSize,
                            helperText: '',
                          ),
                          onSaved: (newValue) => _diskSize = int.parse(newValue!),
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          initialValue: _ram.toString(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            labelText: 'ram'.hardcoded,
                            helperText: '',
                            // helperText: context.$.ramHelperText,
                          ),
                          onSaved: (newValue) => _ram = int.parse(newValue!),
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          initialValue: _nodesNumber.toString(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            labelText: 'nodes number'.hardcoded,
                            helperText: '',
                            // helperText: 'nodes number'.hardcoded,
                          ),
                          onSaved: (newValue) => _nodesNumber = int.parse(newValue!),
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          initialValue: _syncReplicaNumber.toString(),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: 'sync replica number'.hardcoded,
                            helperText: '',
                            // helperText: 'sync replica number'.hardcoded,
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
                            labelText: context.$.description,
                            helperText: ''
                            // helperText: context.$.description,
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
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _pgInstanceBloc.add(
        PgInstanceEvent.createInstance(
          CreatePgInstanceParams(
            name: _name,
            description: _description,
            cores: _cores,
            ram: _ram,
            diskSize: _diskSize,
            nodesNumber: _nodesNumber,
            syncReplicaNumber: _syncReplicaNumber,
            ipsv4: _ipv4List,
          ),
        ),
      );
    }
  }
}

class CreatePgInstancePage extends StatelessWidget {
  const CreatePgInstancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PgInstanceBloc(context.read<IPgInstancesRepository>()),
      child: _CreatePgInstanceView(key: key),
    );
  }
}
