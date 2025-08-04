import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/custom_options_view.dart';
import 'package:go_router/go_router.dart';

class UpdateProjectDialog extends StatefulWidget {
  const UpdateProjectDialog({super.key});

  @override
  State<UpdateProjectDialog> createState() => _UpdateProjectDialogState();
}

class _UpdateProjectDialogState extends State<UpdateProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  late final FocusNode _organizationFocusNode;
  late final _ControllersManager _controllersManager;

  var projectStatus = ProjectStatus.newProject;

  @override
  void initState() {
    super.initState();
    _organizationFocusNode = FocusNode();
    final project = context.read<Project>();

    _controllersManager = _ControllersManager(
      projectName: project.name,
      projectDescription: project.description,
    );
    final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
    context.read<OrganizationsBloc>().add(
      OrganizationsEvent.getOrganizationsByUser(authState.user.uuid),
    );
  }

  Organization? _selectedOrganization;

  @override
  Widget build(BuildContext context) {
    final project = context.read<Project>();

    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectUpdatedState) {
          context.pop();
        }
      },
      child: AlertDialog(
        title: Text('Обновление проекта'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 24,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<OrganizationsBloc, OrganizationsState>(
                      builder: (context, state) {
                        return RawAutocomplete<Organization>(
                          focusNode: _organizationFocusNode,
                          textEditingController: _controllersManager.organizationController,
                          optionsBuilder: (textEditingValue) {
                            if (state is! OrganizationsLoadedState) {
                              return List.empty();
                            }
                            return state.organizations.where(
                              (org) => org.name.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                            );
                          },
                          fieldViewBuilder: (_, controller, focusNode, _) {
                            return TextFormField(
                              focusNode: focusNode,
                              controller: controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(hintText: 'Выберите организацию'),
                            );
                          },
                          displayStringForOption: (option) => option.name,
                          onSelected: (option) {
                            _selectedOrganization = option;
                            _organizationFocusNode.unfocus();
                          },
                          optionsViewBuilder: (context, onSelected, options) {
                            if (state is! OrganizationsLoadedState) {
                              return Center(child: CupertinoActivityIndicator());
                            }
                            return CustomOptionsView(
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: options.length,
                                separatorBuilder: (_, _) => Divider(height: 1, color: Colors.grey[700]),
                                itemBuilder: (_, index) {
                                  final option = options.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelected(option),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(option.name, style: const TextStyle(color: Colors.white)),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                    TextFormField(
                      controller: _controllersManager.projectNameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(hintText: 'Project name'.hardcoded),
                    ),
                    TextFormField(
                      controller: _controllersManager.projectDescriptionController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(hintText: 'Project description'.hardcoded),
                    ),
                    Wrap(
                      spacing: 12,
                      children: [
                        ChoiceChip(
                          label: Text('New'),
                          selected: projectStatus == ProjectStatus.newProject,
                          onSelected: (_) => setState(() => projectStatus = ProjectStatus.newProject),
                        ),
                        ChoiceChip(
                          label: Text('Active'),
                          selected: projectStatus == ProjectStatus.active,
                          onSelected: (_) => setState(() => projectStatus = ProjectStatus.active),
                        ),
                        ChoiceChip(
                          label: Text('In progress'),
                          selected: projectStatus == ProjectStatus.inProgress,
                          onSelected: (_) => setState(() => projectStatus = ProjectStatus.inProgress),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: context.pop, child: Text(context.$.cancel)),
          ListenableBuilder(
            listenable: Listenable.merge(_controllersManager.all),
            builder: (context, asyncSnapshot) {
              return TextButton(
                onPressed: _controllersManager.allFilled
                    ? () {
                        context.read<ProjectBloc>().add(
                          ProjectEvent.update(
                            uuid: project.uuid,
                            name: _controllersManager.projectNameController.text,
                            description: _controllersManager.projectDescriptionController.text,
                            organization: _selectedOrganization?.uuid,
                            status: projectStatus,
                          ),
                        );
                      }
                    : null,
                child: Text(context.$.ok),
              );
            },
          ),
        ],
      ),
    );
  }
}

final class _ControllersManager extends FormControllersManager {
  _ControllersManager({
    required String projectName,
    required String projectDescription,
  }) : projectNameController = TextEditingController(text: projectName),
       projectDescriptionController = TextEditingController(text: projectDescription),
       organizationController = TextEditingController();

  final TextEditingController projectNameController;
  final TextEditingController projectDescriptionController;
  final TextEditingController organizationController;

  @override
  List<TextEditingController> get all => [
    projectNameController,
    projectDescriptionController,
    organizationController,
  ];

  @override
  bool get allFilled => all.every((controller) => controller.text.isNotEmpty);
}
