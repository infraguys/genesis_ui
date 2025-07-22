import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/common/shared_widgets/custom_options_view.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
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

  final chips = [
    _ChipModel(label: 'New', value: ProjectStatus.newProject),
    _ChipModel(label: 'Active', value: ProjectStatus.active),
    _ChipModel(label: 'In progress', value: ProjectStatus.inProgress),
  ];

  @override
  void initState() {
    super.initState();
    _organizationFocusNode = FocusNode();
    _controllersManager = _ControllersManager();

    final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
    context.read<OrganizationsBloc>().add(
      OrganizationsEvent.getOrganizationsByUser(authState.user.uuid),
    );
  }

  Organization? _selectedOrganization;

  @override
  Widget build(BuildContext context) {
    final project = context.read<Project>();
    // final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;

    return AlertDialog(
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
                    children: chips.map(
                      (chip) {
                        return ChoiceChip(
                          label: Text(chip.label),
                          selected: chip.selected,
                          onSelected: (select) {
                            chips.forEach((it) => it.selected = false);
                            chip.selected = !chip.selected;
                            setState(() {});
                          },
                        );
                      },
                    ).toList(),
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
                          status: chips.singleWhere((it) => it.selected).value,
                        ),
                      );
                    }
                  : null,
              child: Text(context.$.ok),
            );
          },
        ),
      ],
    );
  }
}

final class _ControllersManager extends FormControllersManager {
  final projectNameController = TextEditingController();
  final projectDescriptionController = TextEditingController();
  final organizationController = TextEditingController();

  @override
  List<TextEditingController> get all => [
    projectNameController,
    projectDescriptionController,
    organizationController,
  ];

  @override
  bool get allFilled => all.every((controller) => controller.text.isNotEmpty);
}

class _ChipModel {
  _ChipModel({
    required this.label,
    required this.value,
    this.selected = false,
  });

  final String label;
  final ProjectStatus value;
  bool selected;
}
