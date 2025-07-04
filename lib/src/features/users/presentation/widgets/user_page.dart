import 'package:flutter/material.dart';
import 'package:genesis/src/features/shared/user.dart';

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
