import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/breadcrumbs.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/buttons_bar.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class _CreateUserView extends StatefulWidget {
  const _CreateUserView();

  @override
  State<_CreateUserView> createState() => _CreateUserViewState();
}

class _CreateUserViewState extends State<_CreateUserView> {
  final _formKey = GlobalKey<FormState>();
  final _formController = _FormController();
  late final UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (_, current) => switch (current) {
        UserCreatedState() || UserFailureState() => true,
        _ => false,
      },
      listener: (context, state) {
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        switch (state) {
          case UserCreatedState():
            context.read<UsersBloc>().add(UsersEvent.getUsers());
            scaffoldMessenger.showSnackBar(AppSnackBar.success(context.$.success)).closed.then(context.pop);
          case UserFailureState(:final message):
            scaffoldMessenger.showSnackBar(AppSnackBar.failure(message));
          default:
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
                SaveIconButton(onPressed: save),
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

  void save() {
    if (_formKey.currentState!.validate()) {
      _userBloc.add(
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

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return UserBloc(context.read<IUsersRepository>());
          },
        ),
      ],
      child: _CreateUserView(),
    );
  }
}
