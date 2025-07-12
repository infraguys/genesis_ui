import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _organizationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectCreatedState) {
          final snack = SnackBar(
            duration: const Duration(milliseconds: 1000),
            backgroundColor: Colors.green,
            content: Text('Project ${state.project.name} created successfully!'.hardcoded),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          _nameController.clear();
          _descriptionController.clear();
          _organizationController.clear();
        }
      },
      child: Center(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'Project name'.hardcoded),
                ),
                TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'Project description'.hardcoded),
                ),
                // BlocBuilder<AuthBloc, AuthState>(
                //   builder: (context, state) {
                //     return DropdownMenu(
                //       dropdownMenuEntries: (state as AuthenticatedAuthState).iamClient.organizations.map((it) {
                //         return DropdownMenuEntry(value: it.uuid, label: 'cwcwcw');
                //       },).toList(),
                //     );
                //   },
                // ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProjectBloc>().add(
                      ProjectEvent.create(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        organization: _organizationController.text,
                      ),
                    );
                  },
                  child: Text('Create Project'.hardcoded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
