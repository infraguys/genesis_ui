import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/create_node_params.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/create_node_page/blocs/node_bloc/node_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _View extends StatefulWidget {
  const _View({super.key}); // ignore: unused_element_parameter

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();

  late final NodeBloc _nodeBloc;

  var _nodeName = '';
  var _description = '';
  var _cores = 1;
  var _ram = 1024;
  var diskSize = 15;
  var _image = 'http://10.20.0.1:8081/genesis-base/0.2.1/genesis-base.raw.gz';
  var _nodeType = NodeType.vm;

  @override
  void initState() {
    _nodeBloc = context.read<NodeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const gapWidth = 16.0;

    return BlocListener<NodeBloc, NodeState>(
      listenWhen: (_, current) => current.shouldListen,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case NodeCreatedState(:final node):
            context.read<NodesBloc>().add(NodesEvent.getNodes());
            messenger.showSnackBar(AppSnackBar.success(context.$.msgNodeCreated(node.name)));
            context.pop();
          case NodeFailureState(:final message):
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
                  Icon(Icons.hub_rounded, size: 100),
                  SizedBox(width: 32),
                  SizedBox(
                    width: 500,
                    child: AppTextFormInput(
                      initialValue: _nodeName,
                      helperText: context.$.nodeNameHelperText,
                      onSaved: (newValue) => _nodeName = newValue!,
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
                            width: (columnWidth * 2) + gapWidth,
                            child: DropdownMenuFormField<NodeType>(
                              menuStyle: MenuStyle(
                                alignment: Alignment(-1, 0.5),
                                fixedSize: WidgetStatePropertyAll(Size.fromWidth(columnWidth * 2 + gapWidth)),
                              ),
                              width: double.infinity,
                              initialSelection: _nodeType,
                              requestFocusOnTap: false,
                              helperText: context.$.nodeType,
                              onSaved: (newValue) => _nodeType = newValue!,
                              dropdownMenuEntries: [
                                DropdownMenuEntry(
                                  value: NodeType.vm,
                                  label: context.$.virtualMachine,
                                ),
                                DropdownMenuEntry(
                                  value: NodeType.hw,
                                  label: context.$.hardware,
                                ),
                              ],
                            ),
                          ),
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
                              initialValue: _ram.toString(),
                              helperText: context.$.ramLabelText,
                              onSaved: (newValue) => _ram = int.parse(newValue!),
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
                              initialValue: diskSize.toString(),
                              helperText: context.$.diskSize,
                              onSaved: (newValue) => diskSize = int.parse(newValue!),
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                          ),
                          SizedBox(
                            width: (columnWidth * 3) + (gapWidth * 2),
                            child: AppTextFormInput(
                              initialValue: _image,
                              helperText: context.$.image,
                              onSaved: (newValue) => _image = newValue!,
                              validator: (value) => switch (value) {
                                _ when value!.isEmpty => context.$.requiredField,
                                _ => null,
                              },
                            ),
                          ),
                        ],
                      ),
                      AppTextFormInput(
                        initialValue: _description,
                        helperText: context.$.description,
                        onSaved: (newValue) => _description = newValue!,
                        maxLines: 2,
                        minLines: 2,
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
      final params = CreateNodeParams(
        name: _nodeName,
        description: _description,
        cores: _cores,
        ram: _ram,
        rootDiskSize: diskSize,
        image: _image,
        nodeType: _nodeType,
      );
      _nodeBloc.add(NodeEvent.create(params));
    }
  }
}

class CreateNodeDialog extends StatelessWidget {
  const CreateNodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NodeBloc(context.read<INodesRepository>()),
      child: _View(),
    );
  }
}
