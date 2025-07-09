import 'package:flutter/material.dart';
import 'package:genesis/src/domain/entities/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.user, super.key});

  final User user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;

  @override
  void initState() {
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.firstName);
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
                enabled: false,
                decoration: InputDecoration(filled: true, fillColor: Colors.white),
                controller: _firstNameController,
              ),
            ),
            SizedBox(
              width: 400,
              child: TextFormField(
                enabled: false,
                controller: _lastNameController,
                decoration: InputDecoration(filled: true, fillColor: Colors.white),
              ),
            ),
            SizedBox(
              width: 400,
              child: TextFormField(
                decoration: InputDecoration(filled: true, fillColor: Colors.white),
              ),
            ),
            SizedBox(
              width: 400,
              child: TextFormField(
                decoration: InputDecoration(filled: true, fillColor: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserFormControllers extends FormControllersManager {
  _UserFormControllers(User user) {
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
  List<TextEditingController> get all =>
      [
        usernameController,
        descriptionController,
        firstNameController,
        lastNameController,
        surnameController,
        phoneController,
        emailController
      ];

  @override
  bool get allFilled => all.every((it) => it.text.isNotEmpty);
}