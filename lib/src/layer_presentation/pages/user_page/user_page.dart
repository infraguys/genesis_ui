import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/widgets/list_of_projects.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/widgets/user_save_icon_button.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/status_label.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/verified_label.dart';
import 'package:go_router/go_router.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.user, super.key});

  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  late _ControllersManager _controllersManager;

  bool get isValid => _formKey.currentState?.validate() ?? false;

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
          final navigator = GoRouter.of(context);
          late final SnackBar snack;
          if (state is UserStateSuccess) {
            snack = SnackBar(
              backgroundColor: Colors.green,
              content: Text(context.$.success),
              duration: const Duration(milliseconds: 500),
            );
          } else if (state is UserStateFailure) {
            snack = SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message),
              duration: const Duration(milliseconds: 500),
            );
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(
                snack,
              )
              .closed
              .then((_) => navigator.pop());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24.0,
            children: [
              Breadcrumbs(
                items: [
                  BreadcrumbItem(text: context.$.users),
                  BreadcrumbItem(text: widget.user.username),
                ],
              ),
              Row(
                spacing: 4.0,
                children: [
                  Spacer(),
                  UserSaveIconButton(
                    onPressed: () => save(context),
                  ),
                ],
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    height: 410,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              spacing: 24,
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: AppTextInput(
                                    controller: _controllersManager.usernameController,
                                    hintText: context.$.username,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: AppTextInput(
                                    controller: _controllersManager.firstNameController,
                                    hintText: context.$.firstName,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: AppTextInput(
                                    controller: _controllersManager.lastNameController,
                                    hintText: context.$.lastName,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: AppTextInput(
                                    controller: _controllersManager.surnameController,
                                    hintText: context.$.surName,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: AppTextInput(
                                    controller: _controllersManager.phoneController,
                                    hintText: 'Phone'.hardcoded,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  child: AppTextInput(
                                    controller: _controllersManager.emailController,
                                    hintText: context.$.email,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // spacing: 48,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8.0,
                                children: [
                                  Text(context.$.status),
                                  StatusLabel(status: widget.user.status),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8.0,
                                children: [
                                  Text('Верификация'),
                                  VerifiedLabel(isVerified: widget.user.emailVerified),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8.0,
                                children: [
                                  Text(context.$.createdAt),
                                  Text(widget.user.createdAt.toString()),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8.0,
                                children: [
                                  Text(context.$.updatedAt),
                                  Text(widget.user.updatedAt.toString()),
                                ],
                              ),
                              SizedBox(
                                width: constraints.maxWidth * 0.4,
                                child: AppTextInput.multiLine(
                                  controller: _controllersManager.descriptionController,
                                  hintText: context.$.description,
                                  maxLines: 4,
                                  minLines: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Text(context.$.projects, style: textTheme.headlineLarge),
              ListOfProjects(userUuid: widget.user.uuid),
            ],
          ),
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (isValid) {
      context.read<UserBloc>().add(
        UserEvent.updateUser(
          UpdateUserParams(
            uuid: widget.user.uuid,
            username: _controllersManager.usernameController.text,
            description: _controllersManager.descriptionController.text,
            firstName: _controllersManager.firstNameController.text,
            lastName: _controllersManager.lastNameController.text,
            surname: _controllersManager.surnameController.text,
            phone: _controllersManager.phoneController.text,
            email: _controllersManager.emailController.text,
          ),
        ),
      );
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
}
