import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get isSignInBtnEnabled {
    return _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final $ = context.$;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateFailure) {
          final snack = SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF1B1B1D).hardcoded,
        body: Center(
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 250,
                    height: 250,
                  ),
                  Text(
                    '${context.$.genesis} ${context.$.core}',
                    style: textTheme.headlineLarge?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Login'.hardcoded),
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
                    decoration: InputDecoration(hintText: $.password),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  ListenableBuilder(
                    listenable: Listenable.merge([
                      _usernameController,
                      _passwordController,
                    ]),
                    builder: (context, _) {
                      return ElevatedButton(
                        onPressed: isSignInBtnEnabled ? () => signIn(context) : null,
                        child: Text($.signIn),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.signUp.name);
                    },
                    child: Text($.signUp),
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
      final event = AuthEvent.signIn(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      context.read<AuthBloc>().add(event);
    }
  }
}
