import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/interfaces/form_controllers.dart';
import 'package:genesis/src/presentation/features/users/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/presentation/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = _FormControllers();

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final $ = context.$;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserStateCreatedFailure) {
          final snack = SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
        } else if (state is UserStateCreatedSuccess) {
          final navigator = GoRouter.of(context);
          final snack = SnackBar(
            backgroundColor: Colors.green,
            content: Text(context.$.success),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snack)
              .closed
              .then(
                (_) => navigator.pop(),
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
                    controller: _controllers.username,
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
                    controller: _controllers.firstName,
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
                    controller: _controllers.lastName,
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
                    controller: _controllers.email,
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
                    controller: _controllers.password,
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
                    listenable: Listenable.merge(_controllers.all),
                    builder: (context, _) {
                      return ElevatedButton(
                        onPressed: _controllers.allFilled ? () => signIn(context) : null,
                        child: Text($.signUp),
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
                    child: Text($.goBack),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final event = UserEvent.createUser(
        username: _controllers.username.text,
        firstName: _controllers.firstName.text,
        lastName: _controllers.lastName.text,
        email: _controllers.email.text,
        password: _controllers.password.text,
      );
      context.read<UserBloc>().add(event);
    }
  }
}

class _FormControllers extends FormControllersManager {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  List<TextEditingController> get all => [firstName, lastName, email, username, password];

  @override
  bool get allFilled => all.every((c) => c.text.isNotEmpty);
}
