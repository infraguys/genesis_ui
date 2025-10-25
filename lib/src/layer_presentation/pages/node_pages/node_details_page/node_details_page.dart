import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/domain/params/update_node_params.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/nodes/presentation/widgets/node_status_widget.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/node_pages/create_node_page/blocs/node_bloc/node_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/delete_elevated_button.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_progress_indicator.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/confirmation_dialog.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
          final NodeLoadedState(:node) = state;
          return PageLayout(
            breadcrumbs: [
              BreadcrumbItem(text: context.$.nodes),
              BreadcrumbItem(text: node.name),
            ],
            buttonsBar: ButtonsBar(
              children: [
                _DeleteNodeButton(node: node),
                SaveIconButton(onPressed: save),
              ],
            ),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.hub_rounded, size: 100),
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
                                        node.id.value,
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
                                          Clipboard.setData(ClipboardData(text: node.id.value));
                                          final msg = context.$.msgCopiedToClipboard(node.id.value);
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
                                  helperText: context.$.name,
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
                            defaultColumnWidth: FixedColumnWidth(200),
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(context.$.status),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NodeStatusWidget(status: node.status),
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
                                    child: Text(DateFormat('dd.MM.yyyy HH:mm').format(node.createdAt)),
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
                                    child: Text(DateFormat('dd.MM.yyyy HH:mm').format(node.updatedAt)),
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
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 16.0,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16.0,
                        children: [
                          Expanded(
                            child: Column(
                              spacing: 16.0,
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    return DropdownMenuFormField<NodeType>(
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
                                    );
                                  },
                                ),
                                AppTextFormInput(
                                  initialValue: _image,
                                  helperText: context.$.image,
                                  onSaved: (newValue) => _image = newValue!,
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                                AppTextFormInput(
                                  initialValue: _cores.toString(),
                                  helperText: context.$.cores,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onSaved: (newValue) => _cores = int.parse(newValue!),
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 16.0,
                              children: [
                                AppTextFormInput(
                                  initialValue: _rootDiskSize.toString(),
                                  helperText: context.$.diskSize,
                                  onSaved: (newValue) => _rootDiskSize = int.parse(newValue!),
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                                AppTextFormInput(
                                  initialValue: _ram.toString(),
                                  helperText: context.$.ramLabelText,
                                  onSaved: (newValue) => _ram = int.parse(newValue!),
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                                AppTextFormInput(
                                  readOnly: true,
                                  initialValue: _ipv4,
                                  helperText: 'ipv4'.hardcoded,
                                ),
                              ],
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
                  ),
                ),
              ),
            ],
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
