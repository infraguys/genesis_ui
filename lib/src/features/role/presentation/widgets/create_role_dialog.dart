import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateRoleDialog extends StatefulWidget {
  const CreateRoleDialog({super.key});

  @override
  State<CreateRoleDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateRoleDialog> {
  final _formKey = GlobalKey<FormState>();

  late final _ControllersManager _controllersManager;

  @override
  void initState() {
    super.initState();
    _controllersManager = _ControllersManager();
    final authState = context.read<AuthBloc>().state as AuthenticatedAuthState;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Создание Роли'),
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
                  TextFormField(
                    controller: _controllersManager.roleNameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Role name'.hardcoded),
                  ),
                  TextFormField(
                    controller: _controllersManager.roleDescriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Role description'.hardcoded),
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
              onPressed: _controllersManager.allFilled ? () {} : null,
              child: Text(context.$.ok),
            );
          },
        ),
      ],
    );
  }
}

final class _ControllersManager extends FormControllersManager {
  final roleNameController = TextEditingController();
  final roleDescriptionController = TextEditingController();

  @override
  List<TextEditingController> get all {
    return [roleNameController, roleDescriptionController];
  }

  @override
  bool get allFilled => all.every((controller) => controller.text.isNotEmpty);
}
