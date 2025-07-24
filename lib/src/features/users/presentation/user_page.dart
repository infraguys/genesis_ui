import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/projects/presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/features/projects/presentation/widgets/list_of_projects.dart';
import 'package:genesis/src/features/role/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/features/role/presentation/widgets/roles_list.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.user, super.key});

  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  late _ControllersManager _controllersManager;

  @override
  void initState() {
    context.read<UserProjectsBloc>().add(UserProjectsEvent.getProjects(widget.user.uuid));
    context.read<UserRolesBloc>().add(UserRolesEvent.getRoles(widget.user.uuid));
    _controllersManager = _ControllersManager(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserStateUpdateSuccess) {
          final snack = SnackBar(
            backgroundColor: Colors.green,
            content: Text(context.$.success),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
        } else if (state is UserStateFailure) {
          final snack = SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 48,
            children: [
              RolesList(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.usernameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.username,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.descriptionController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.description,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.firstNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.firstName,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.lastNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.lastName,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.surnameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.surName,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.phoneController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Phone'.hardcoded,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: context.$.email,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () => save(context),
                        child: Text(context.$.save),
                      ),
                    ),
                  ],
                ),
              ),
              ListOfProjects(userUuid: widget.user.uuid),
            ],
          ),
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final event = UserEvent.updateUser(
        uuid: widget.user.uuid,
        username: _controllersManager.usernameController.text,
        description: _controllersManager.descriptionController.text,
        firstName: _controllersManager.firstNameController.text,
        lastName: _controllersManager.lastNameController.text,
        surname: _controllersManager.surnameController.text,
        phone: _controllersManager.phoneController.text,
        email: _controllersManager.emailController.text,
      );
      context.read<UserBloc>().add(event);
    }
  }
}

class _ControllersManager extends FormControllersManager {
  _ControllersManager(User user) {
    usernameController = TextEditingController(text: user.username);
    descriptionController = TextEditingController(text: user.description);
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    surnameController = TextEditingController(text: user.surname);
    phoneController = TextEditingController(text: user.phone);
    emailController = TextEditingController(text: user.email);
  }

  late final TextEditingController usernameController;
  late final TextEditingController descriptionController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController surnameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  List<TextEditingController> get all => [
    usernameController,
    descriptionController,
    firstNameController,
    lastNameController,
    surnameController,
    phoneController,
    emailController,
  ];

  @override
  bool get allFilled => all.every((it) => it.text.isNotEmpty);
}
