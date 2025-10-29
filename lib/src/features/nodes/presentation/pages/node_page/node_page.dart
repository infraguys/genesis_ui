import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/update_node_params.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/node_bloc/node_bloc.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/form_card.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/id_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/metadata_table.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/node_status_widget.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

part 'widgets/delete_node_btn.dart';

class _View extends StatefulWidget {
  const _View({required this.id, super.key}); //ignore: unused_element_parameter

  final NodeID id;

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _formKey = GlobalKey<FormState>();

  late final NodeBloc _nodeBloc;

  late String _nodeName;
  late String _description;
  late int _cores;
  late int _ram;
  late int _diskSize;
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
    const gapWidth = 16.0;

    return BlocListener<NodeBloc, NodeState>(
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case NodeLoadedState(:final node):
            _nodeName = node.name;
            _description = node.description;
            _cores = node.cores;
            _ram = node.ram;
            _diskSize = node.rootDiskSize;
            _image = node.image;
            _nodeType = node.nodeType;
            _ipv4 = node.ipv4;

          case NodeUpdatedState(:final node):
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
          final NodeLoadedState(:node) = state;
          return Form(
            key: _formKey,
            child: PageLayout(
              breadcrumbs: [
                BreadcrumbItem(text: context.$.nodes),
                BreadcrumbItem(text: node.name),
              ],
              buttons: [
                _DeleteNodeButton(node: node),
                SaveIconButton(onPressed: save),
              ],
              child: Column(
                spacing: gapWidth,
                children: [
                  FormCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.hub_rounded, size: 100),
                        SizedBox(width: 32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: gapWidth,
                          children: [
                            IdWidget(id: node.id.value),
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
                        Spacer(),
                        MetadataTable(
                          statusWidget: NodeStatusWidget(status: node.status),
                          createdAt: node.createdAt,
                          updatedAt: node.updatedAt,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: gapWidth,
                              children: [
                                SizedBox(
                                  width: columnWidth * 2 + gapWidth,
                                  child: DropdownMenuFormField<NodeType>(
                                    menuStyle: MenuStyle(
                                      alignment: Alignment(-1, 0.5),
                                      fixedSize: WidgetStatePropertyAll(Size.fromWidth(constraints.maxWidth)),
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
                                    initialValue: _diskSize.toString(),
                                    helperText: context.$.diskSize,
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
                                    readOnly: true,
                                    initialValue: _ipv4,
                                    helperText: 'ipv4'.hardcoded,
                                  ),
                                ),
                                SizedBox(
                                  width: (columnWidth * 2) + gapWidth,
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
      _nodeBloc.add(
        NodeEvent.update(
          UpdateNodeParams(
            id: widget.id,
            name: _nodeName,
            image: _image,
            cores: _cores,
            rootDiskSize: _diskSize,
            ram: _ram,
            nodeType: _nodeType,
            description: _description,
          ),
        ),
      );
    }
  }
}

class NodePage extends StatelessWidget {
  const NodePage({required this.id, super.key});

  final NodeID id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NodeBloc(context.read<INodesRepository>())..add(NodeEvent.getNode(id)),
      child: _View(id: id),
    );
  }
}
