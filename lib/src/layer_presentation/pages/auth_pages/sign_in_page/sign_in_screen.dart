import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late final AuthBloc _authBloc;

  var _username = '';
  var _password = '';

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case AuthStateFailure(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
          default:
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: 'Login'.hardcoded),
                    onSaved: (newValue) => _username = newValue!,
                    validator: (value) => switch (value) {
                      _ when value!.isEmpty => context.$.requiredField,
                      _ => null,
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: context.$.password),
                    obscureText: true,
                    onSaved: (newValue) => _password = newValue!,
                    validator: (value) => switch (value) {
                      _ when value!.isEmpty => context.$.requiredField,
                      _ => null,
                    },
                  ),
                  ElevatedButton(
                    onPressed: signIn,
                    child: Text(context.$.signIn),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final username = await context.pushNamed<String>(AppRoutes.signUp.name);
                      if (username != null) {
                        _username = username;
                      }
                    },
                    child: Text(context.$.signUp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _authBloc.add(
        AuthEvent.signIn(username: _username, password: _password),
      );
    }
  }
}
