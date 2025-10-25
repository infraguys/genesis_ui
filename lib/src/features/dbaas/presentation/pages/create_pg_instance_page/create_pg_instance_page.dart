import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instance_bloc/pg_instance_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
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

  var _clusterName = '';
  String? _description;
  var _cores = 1;
  var _ram = 512;
  var _diskSize = 10;
  var _nodesNumber = 1;
  var _ipsv4List = <String>[];
  var _syncReplicaNumber = 1;
  var _versionLink = '/v1/types/postgres/versions/26786c09-d175-44e5-9013-ac14c88acd1c';

  @override
  void initState() {
    _pgInstanceBloc = context.read<PgInstanceBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gapWidth = 16.0;

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
                      initialValue: _clusterName,
                      helperText: context.$.pgClusterName,
                      onSaved: (newValue) => _clusterName = newValue!,
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
      _pgInstanceBloc.add(
        PgInstanceEvent.createInstance(
          CreatePgInstanceParams(
            name: _clusterName,
            description: _description,
            cores: _cores,
            ram: _ram,
            diskSize: _diskSize,
            nodesNumber: _nodesNumber,
            syncReplicaNumber: _syncReplicaNumber,
            ipsv4: _ipsv4List,
            versionLink: _versionLink,
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
