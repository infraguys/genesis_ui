import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  final _formKey = GlobalKey<FormState>();

  late _ControllersManager _controllersManager;

  @override
  void initState() {
    // context.read<UserProjectsBloc>().add(UserProjectsEvent.getProjects(widget.user.uuid));
    // context.read<UserRolesBloc>().add(UserRolesEvent.getRoles(widget.user.uuid));
    _controllersManager = _ControllersManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        // if (state is UserStateUpdateSuccess) {
        //   final snack = SnackBar(
        //     backgroundColor: Colors.green,
        //     content: Text(context.$.success),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snack);
        // } else if (state is UserStateFailure) {
        //   final snack = SnackBar(
        //     backgroundColor: Colors.red,
        //     content: Text(state.message),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snack);
        // }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 48,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _controllersManager.nameController,
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
                      child: ElevatedButton(
                        onPressed: () => save(context),
                        child: Text(context.$.save),
                      ),
                    ),
                  ],
                ),
              ),
              // ListOfProjects(userUuid: widget.user.uuid),
            ],
          ),
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {}
  }
}

class _ControllersManager extends FormControllersManager {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  List<TextEditingController> get all => [nameController, descriptionController];

  @override
  bool get allFilled => all.every((it) => it.text.isNotEmpty);
}
