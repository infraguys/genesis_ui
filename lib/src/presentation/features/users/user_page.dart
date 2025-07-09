import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/domain/entities/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.user, super.key});

  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late _ControllersManager _controllersManager;

  @override
  void initState() {
    _controllersManager = _ControllersManager(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
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
          ],
        ),
      ),
    );
  }
}

class _ControllersManager extends FormControllersManager {
  _ControllersManager(User user) {
    usernameController = TextEditingController(text: user.username);
    descriptionController = TextEditingController(text: user.description);
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    surnameController = TextEditingController(text: user.surname);
    phoneController = TextEditingController(text: user.phone ?? '');
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
