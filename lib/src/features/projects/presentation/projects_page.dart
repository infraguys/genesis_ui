import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/features/projects/presentation/widgets/project_action_popup_menu_button.dart';
import 'package:provider/provider.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthenticatedAuthState) {
      context.read<ProjectsBloc>().add(ProjectsEvent.getProjects(authState.user.uuid));
    }
    super.initState();
  }

  // final _formKey = GlobalKey<FormState>();
  //
  // final _nameController = TextEditingController();
  // final _descriptionController = TextEditingController();
  // final _organizationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Проекты',
          style: textTheme.headlineMedium,
        ),
        BlocBuilder<ProjectsBloc, ProjectsState>(
          builder: (context, state) {
            if (state is! ProjectsLoadedState) {
              return Center(child: CupertinoActivityIndicator());
            }
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320,
                mainAxisExtent: 250,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.projects.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Card(
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  );
                }
                final project = state.projects[index - 1];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              project.name,
                              style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Provider.value(
                              value: project,
                              child: ProjectActionPopupMenuButton(),
                            ),
                          ],
                        ),
                        Text(project.createdAt.toString(), style: textTheme.bodySmall),
                        Text(project.description, style: textTheme.bodySmall),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Роли',
                          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
    // return BlocListener<ProjectBloc, ProjectState>(
    //   listener: (context, state) {
    //     if (state is ProjectCreatedState) {
    //       final snack = SnackBar(
    //         duration: const Duration(milliseconds: 1000),
    //         backgroundColor: Colors.green,
    //         content: Text('Project ${state.project.name} created successfully!'.hardcoded),
    //       );
    //       ScaffoldMessenger.of(context).showSnackBar(snack);
    //       _nameController.clear();
    //       _descriptionController.clear();
    //       _organizationController.clear();
    //     }
    //   },
    //   child: Center(
    //     child: Form(
    //       key: _formKey,
    //       child: SizedBox(
    //         width: 500,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           spacing: 24,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             TextFormField(
    //               controller: _nameController,
    //               style: TextStyle(color: Colors.white),
    //               decoration: InputDecoration(hintText: 'Project name'.hardcoded),
    //             ),
    //             TextFormField(
    //               controller: _descriptionController,
    //               style: TextStyle(color: Colors.white),
    //               decoration: InputDecoration(hintText: 'Project description'.hardcoded),
    //             ),
    //             // BlocBuilder<AuthBloc, AuthState>(
    //             //   builder: (context, state) {
    //             //     return DropdownMenu(
    //             //       dropdownMenuEntries: (state as AuthenticatedAuthState).iamClient.organizations.map((it) {
    //             //         return DropdownMenuEntry(value: it.uuid, label: 'cwcwcw');
    //             //       },).toList(),
    //             //     );
    //             //   },
    //             // ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 context.read<ProjectBloc>().add(
    //                   ProjectEvent.create(
    //                     name: _nameController.text,
    //                     description: _descriptionController.text,
    //                     organization: _organizationController.text,
    //                   ),
    //                 );
    //               },
    //               child: Text('Create Project'.hardcoded),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
