import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/update_node_params.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/create_node_page/blocs/node_bloc/node_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:genesis/src/features/nodes/presentation/widgets/node_status_widget.dart';
import 'package:go_router/go_router.dart';

part './widgets/delete_node_btn.dart';

class _NodeDetailsView extends StatefulWidget {
  const _NodeDetailsView({required this.id, super.key}); //ignore: unused_element_parameter

  final NodeID id;

  @override
  State<_NodeDetailsView> createState() => _NodeDetailsViewState();
}

class _NodeDetailsViewState extends State<_NodeDetailsView> {
  final _formKey = GlobalKey<FormState>();

  late final NodeBloc _nodeBloc;

  late String _name;
  late String _description;
  late int _cores;
  late int _ram;
  late int _rootDiskSize;
  late String _image;
  late NodeType _nodeType;
  late String _ipv4;

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
        final navigator = GoRouter.of(context);
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case NodeLoadedState(:final node):
            _name = node.name;
            _description = node.description;
            _cores = node.cores;
            _ram = node.ram;
            _rootDiskSize = node.rootDiskSize;
            _image = node.image;
            _nodeType = node.nodeType;
            _ipv4 = node.ipv4;

          case NodeUpdatedState(:final node):
            _nodeBloc.add(NodeEvent.getNode(widget.id));
            messenger.showSnackBar(AppSnackBar.success(context.$.msgNodeUpdated(node.name)));
            context.read<NodesBloc>().add(NodesEvent.getNodes());

          case NodeDeletedState(:final node):
            messenger.showSnackBar(AppSnackBar.success(context.$.msgNodeDeleted(node.name)));
            context.read<NodesBloc>().add(NodesEvent.getNodes());
            navigator.pop();

          case NodePermissionFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(context.$.msgPermissionDenied(message)));
          case NodeFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
        }
      },
      child: BlocBuilder<NodeBloc, NodeState>(
        buildWhen: (_, current) => current is NodeLoadingState || current is NodeLoadedState,
        builder: (context, state) {
          if (state is! NodeLoadedState) {
            return AppProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                Breadcrumbs(
                  items: [
                    BreadcrumbItem(text: context.$.nodes),
                    BreadcrumbItem(text: state.node.name),
                  ],
                ),
                ButtonsBar(
                  children: [
                    _DeleteNodeButton(node: state.node),
                    SaveIconButton(onPressed: save),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 128,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: [
                                TextFormField(
                                  initialValue: _name,
                                  decoration: InputDecoration(
                                    hintText: context.$.name,
                                    helperText: context.$.name,
                                  ),
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
                                      label: 'Hardware',
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  initialValue: _image,
                                  decoration: InputDecoration(
                                    hintText: context.$.image,
                                    helperText: context.$.image,
                                  ),
                                  onSaved: (newValue) => _image = newValue!,
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                                TextFormField(
                                  initialValue: _cores.toString(),
                                  decoration: InputDecoration(
                                    hintText: 'cores'.hardcoded,
                                    helperText: 'cores'.hardcoded,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onSaved: (newValue) => _cores = int.parse(newValue!),
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                                TextFormField(
                                  initialValue: _rootDiskSize.toString(),
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
                                  initialValue: _ram.toString(),
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
                                  readOnly: true,
                                  initialValue: _ipv4,
                                  decoration: InputDecoration(
                                    hintText: 'ipV4'.hardcoded,
                                    helperText: 'ipV4'.hardcoded,
                                  ),
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
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 32,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8.0,
                                children: [
                                  Text(context.$.status),
                                  NodeStatusWidget(status: state.node.status),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8.0,
                                children: [
                                  Text(context.$.createdAt),
                                  Text(state.node.createdAt.toString()),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8.0,
                                children: [
                                  Text(context.$.updatedAt),
                                  Text(state.node.updatedAt.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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
      _nodeBloc.add(
        NodeEvent.update(
          UpdateNodeParams(
            id: widget.id,
            name: _name,
            image: _image,
            cores: _cores,
            rootDiskSize: _rootDiskSize,
            ram: _ram,
            nodeType: _nodeType,
            description: _description,
          ),
        ),
      );
    }
  }
}

class NodeDetailsPage extends StatelessWidget {
  const NodeDetailsPage({required this.id, super.key});

  final NodeID id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NodeBloc(context.read<INodesRepository>())..add(NodeEvent.getNode(id)),
      child: _NodeDetailsView(id: id),
    );
  }
}
