import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/widgets/list_of_projects.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';

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
    context.read<UserRolesBloc>().add(UserRolesEvent.getRolesByUser(widget.user.uuid));
    _controllersManager = _ControllersManager(widget.user);
    super.initState();
  }

  @override
  void dispose() {
    _controllersManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          late final SnackBar snack;
          if (state is UserStateUpdateSuccess) {
            snack = SnackBar(backgroundColor: Colors.green, content: Text(context.$.success));
          } else if (state is UserStateFailure) {
            snack = SnackBar(backgroundColor: Colors.red, content: Text(state.message));
          }
          ScaffoldMessenger.of(context).showSnackBar(snack);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 48,
            children: [
              Breadcrumbs(
                items: [
                  BreadcrumbItem(text: context.$.users),
                  BreadcrumbItem(text: widget.user.username),
                ],
              ),
              // RolesList(),
              Theme(
                data:
                    Theme.of(
                      context,
                    ).copyWith(
                      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                        isDense: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24,
                    children: [
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _controllersManager.usernameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: context.$.username,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          // enabled: false,
                          controller: _controllersManager.descriptionController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: context.$.description,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _controllersManager.firstNameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: context.$.firstName,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _controllersManager.lastNameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: context.$.lastName,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _controllersManager.surnameController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: context.$.surName,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _controllersManager.phoneController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Phone'.hardcoded,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: _controllersManager.emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
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
              ),
              Text('Проекты', style: textTheme.headlineLarge),
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
  _ControllersManager(User user)
    : usernameController = TextEditingController(text: user.username),
      descriptionController = TextEditingController(text: user.description),
      firstNameController = TextEditingController(text: user.firstName),
      lastNameController = TextEditingController(text: user.lastName),
      surnameController = TextEditingController(text: user.surname),
      phoneController = TextEditingController(text: user.phone),
      emailController = TextEditingController(text: user.email);

  final TextEditingController usernameController;
  final TextEditingController descriptionController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController surnameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

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
