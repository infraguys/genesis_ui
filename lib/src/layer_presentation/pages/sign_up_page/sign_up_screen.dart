import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formController = _FormController();
  late final UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        late SnackBar snack;

        if (state is UserFailureState) {
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
        backgroundColor: Color(0xFF1B1B1D).hardcoded,
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  Text(
                    '${context.$.genesis} ${context.$.core}',
                    style: textTheme.headlineLarge?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: _formController.username,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Username'.hardcoded),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _formController.firstName,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'First name'.hardcoded),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _formController.lastName,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Last name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _formController.email,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'E-mail'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _formController.password,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  ListenableBuilder(
                    listenable: Listenable.merge(_formController.all),
                    builder: (context, _) {
                      return ElevatedButton(
                        onPressed: _formController.allFilled ? save : null,
                        child: Text(context.$.signUp),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.goNamed(AppRoutes.signIn.name);
                      }
                    },
                    child: Text(context.$.goBack),
                  ),
                ],
              ),
            ),
          ),
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
