import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/user/presentation/blocs/user_bloc/user_bloc.dart';

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
    _controllersManager = _ControllersManager(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
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
              Wrap(
                spacing: 12,
                children: [
                  Chip(label: Text('Admin'), backgroundColor: Colors.blue,),
                  Chip(label: Text('Manager'), backgroundColor: Colors.orange,),
                ],
              ),
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
                      hintText: 'username'.hardcoded,
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
                      hintText: 'Decscription'.hardcoded,
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
                      hintText: 'First name'.hardcoded,
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
                      hintText: 'Last name'.hardcoded,
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
                      hintText: 'Surname',
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
                      hintText: 'Email'.hardcoded,
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () => save(context),
                    child: Text('Save'.hardcoded),
                  ),
                ),
                Text('Проекты', style: textTheme.headlineSmall),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 250,
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 250,
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 250,
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 250,
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text('No projects yet'.hardcoded, style: textTheme.bodyMedium)
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
            ],
        ),
        ),
      ),);
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
  List<TextEditingController> get all =>
      [
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
