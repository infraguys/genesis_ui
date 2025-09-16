import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/params/nodes_params/create_node_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/create_node_page/blocs/node_bloc/node_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
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
  final _formController = _FormController();
  late final NodeBloc _nodeBloc;

  var _nodeType = NodeType.vm;

  @override
  void initState() {
    _nodeBloc = context.read<NodeBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _formController.dispose();
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
                      AppTextInput(
                        controller: _formController.name,
                        hintText: context.$.name,
                        validator: (value) => switch (value) {
                          _ when value!.isEmpty => context.$.requiredField,
                          _ => null,
                        },
                      ),
                      DropdownMenuFormField<NodeType>(
                        controller: _formController.nodeType,
                        menuStyle: MenuStyle(
                          fixedSize: WidgetStatePropertyAll(Size.fromWidth(constraints.maxWidth * 0.4)),
                        ),
                        width: double.infinity,
                        initialSelection: _nodeType,
                        requestFocusOnTap: false,
                        onSaved: (newValue) => _nodeType = newValue!,
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                            value: NodeType.vm,
                            label: 'Virtual machine',
                          ),
                          DropdownMenuEntry(
                            value: NodeType.hw,
                            label: 'Hardware',
                          ),
                        ],
                      ),
                      // AppTextInput(
                      //   controller: _formController.image,
                      //   hintText: 'image'.hardcoded,
                      //   validator: (value) => switch (value) {
                      //     _ when value!.isEmpty => context.$.requiredField,
                      //     _ => null,
                      //   },
                      // ),
                      AppTextInput(
                        controller: _formController.cores,
                        hintText: 'cores'.hardcoded,
                        validator: (value) => switch (value) {
                          _ when value!.isEmpty => context.$.requiredField,
                          _ => null,
                        },
                      ),
                      AppTextInput(
                        controller: _formController.rootDiskSize,
                        hintText: 'root disk size'.hardcoded,
                        validator: (value) => switch (value) {
                          _ when value!.isEmpty => context.$.requiredField,
                          _ => null,
                        },
                      ),
                      AppTextInput(
                        controller: _formController.ram,
                        hintText: 'ram'.hardcoded,
                        obscureText: true,
                        validator: (value) => switch (value) {
                          _ when value!.isEmpty => context.$.requiredField,
                          _ => null,
                        },
                      ),
                      AppTextInput(
                        controller: _formController.description,
                        hintText: context.$.description,
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
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _nodeBloc.add(
        NodeEvent.create(
          CreateNodeParams(
            name: _formController.name.text,
            description: _formController.description.text,
            cores: int.parse(_formController.cores.text),
            ram: int.parse(_formController.ram.text),
            rootDiskSize: int.parse(_formController.rootDiskSize.text),
            image: 'http://10.20.0.1:8081/genesis-base/0.2.1/genesis-base.raw.gz',
            nodeType: _nodeType,
          ),
        ),
      );
    }
  }
}

//{
//   "name": "",
//   "description": "",
//   "cores": 4096,
//   "ram": 9223372036854776000,
//   "root_disk_size": 15,
//   "image": "string",
//   "node_type": "VM",
//   "default_network": {}
// }

class _FormController extends FormControllersManager {
  final name = TextEditingController();
  final description = TextEditingController();
  final cores = TextEditingController();
  final ram = TextEditingController();
  final rootDiskSize = TextEditingController();
  final image = TextEditingController();
  final nodeType = TextEditingController();

  @override
  List<TextEditingController> get all => [name, description, cores, ram, rootDiskSize, image, nodeType];
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
