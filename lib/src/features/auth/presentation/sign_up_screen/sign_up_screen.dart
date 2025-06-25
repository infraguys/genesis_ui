import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/auth/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get isSignUpBtnEnabled {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final $ = context.$;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserStateSignUpFailure) {
          final snack = SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
        } else if (state is UserStateSignUpSuccess) {
          final navigator = GoRouter.of(context);
          final snack = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Success!'),
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
                    controller: _usernameController,
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
                    controller: _firstNameController,
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
                    controller: _lastNameController,
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
                    controller: _emailController,
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
                    controller: _passwordController,
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
                    listenable: Listenable.merge([
                      _firstNameController,
                      _lastNameController,
                      _emailController,
                      _passwordController,
                      _usernameController,
                    ]),
                    builder: (context, _) {
                      return ElevatedButton(
                        onPressed: isSignUpBtnEnabled ? () => signIn(context) : null,
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
      final event = UserEvent.singUp(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      context.read<UserBloc>().add(event);
    }
  }
}
