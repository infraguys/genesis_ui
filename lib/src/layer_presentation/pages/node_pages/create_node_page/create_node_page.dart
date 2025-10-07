import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/create_node_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/create_node_page/blocs/node_bloc/node_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreateNodeView extends StatefulWidget {
  const _CreateNodeView({super.key});

  @override
  State<_CreateNodeView> createState() => _CreateNodeViewState();
}

class _CreateNodeViewState extends State<_CreateNodeView> {
  final _formKey = GlobalKey<FormState>();

  late final NodeBloc _nodeBloc;

  var _name = '';
  var _description = '';
  var _cores = 1;
  var _ram = 1024;
  var _rootDiskSize = 15;
  var _image = 'http://10.20.0.1:8081/genesis-base/0.2.1/genesis-base.raw.gz';
  var _nodeType = NodeType.vm;

  @override
  void initState() {
    _nodeBloc = context.read<NodeBloc>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NodeBloc, NodeState>(
      listener: (context, state) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        switch (state) {
          case NodeCreatedState():
            context.read<NodesBloc>().add(NodesEvent.getNodes());
            scaffoldMessenger.showSnackBar(AppSnackBar.success(context.$.msgNodeCreated(state.node.name)));
            context.pop();
          case NodeFailureState(:final message):
            scaffoldMessenger.showSnackBar(AppSnackBar.failure(message));
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
                BreadcrumbItem(text: context.$.nodes),
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
                        DropdownMenuFormField<NodeType>(
                          menuStyle: MenuStyle(
                            fixedSize: WidgetStatePropertyAll(Size.fromWidth(constraints.maxWidth * 0.4)),
                          ),
                          width: double.infinity,
                          initialSelection: _nodeType,
                          helperText: context.$.nodeType,
                          requestFocusOnTap: false,
                          onSaved: (newValue) => _nodeType = newValue!,
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                              value: NodeType.vm,
                              label: context.$.virtualMachine,
                            ),
                            DropdownMenuEntry(
                              value: NodeType.hw,
                              label: 'Hardware',
                            ),
                          ],
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          initialValue: _image,
                          decoration: InputDecoration(hintText: context.$.image, helperText: context.$.image),
                          onSaved: (newValue) => _image = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          initialValue: _cores.toString(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                          initialValue: _rootDiskSize.toString(),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            hintText: context.$.rootDiskSize,
                            helperText: context.$.rootDiskSize,
                          ),
                          onSaved: (newValue) => _rootDiskSize = int.parse(newValue!),
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUnfocus,
                          initialValue: _ram.toString(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
      ),
    );
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _nodeBloc.add(
        NodeEvent.create(
          CreateNodeParams(
            name: _name,
            description: _description,
            cores: _cores,
            ram: _ram,
            rootDiskSize: _rootDiskSize,
            image: _image,
            nodeType: _nodeType,
          ),
        ),
      );
    }
  }
}

class CreateNodePage extends StatelessWidget {
  const CreateNodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NodeBloc(context.read<INodesRepository>()),
      child: _CreateNodeView(key: key),
    );
  }
}
