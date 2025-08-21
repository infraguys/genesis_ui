import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _formController = _FormController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        late SnackBar snack;

        if (state is UserStateFailure) {
          snack = AppSnackBar.failure(state.message);
          scaffoldMessenger.showSnackBar(snack);
        } else if (state is UserCreatedState) {
          final snack = AppSnackBar.success(context.$.success);
          scaffoldMessenger
              .showSnackBar(snack)
              .closed
              .then(
                (_) => navigator.pop(state.user.username),
              );
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            Breadcrumbs(
              items: [
                BreadcrumbItem(text: context.$.users),
                BreadcrumbItem(text: context.$.create),
              ],
            ),
            ButtonsBar(
              children: [
                SaveIconButton(onPressed: () => save(context)),
              ],
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        AppTextInput(
                          controller: _formController.username,
                          hintText: context.$.username,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        AppTextInput(
                          controller: _formController.firstName,
                          hintText: context.$.firstName,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        AppTextInput(
                          controller: _formController.lastName,
                          hintText: context.$.lastName,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        AppTextInput(
                          controller: _formController.email,
                          hintText: context.$.email,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        AppTextInput(
                          controller: _formController.password,
                          hintText: context.$.password,
                          obscureText: true,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void save(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserBloc>().add(
        UserEvent.createUser(
          CreateUserParams(
            username: _formController.username.text,
            firstName: _formController.firstName.text,
            lastName: _formController.lastName.text,
            email: _formController.email.text,
            password: _formController.password.text,
          ),
        ),
      );
    }
  }
}

class _FormController extends FormControllersManager {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  List<TextEditingController> get all => [firstName, lastName, email, username, password];
}
