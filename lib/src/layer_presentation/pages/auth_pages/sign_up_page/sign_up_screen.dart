import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
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
  late final UserBloc _userBloc;

  var _username = '';
  var _firstName = '';
  var _lastName = '';
  var _email = '';
  var _password = '';

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        final navigator = GoRouter.of(context);
        final scaffoldMessenger = ScaffoldMessenger.of(context);

        late SnackBar snack;

        // todo(koretsky): Сделать рефакторинг
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
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: context.$.username),
                    onSaved: (newValue) => _username = newValue!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: context.$.firstName),
                    onSaved: (newValue) => _firstName = newValue!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: context.$.lastName),
                    onSaved: (newValue) => _lastName = newValue!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: context.$.email),
                    onSaved: (newValue) => _email = newValue!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: context.$.password),
                    obscureText: true,
                    onSaved: (newValue) => _password = newValue!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required'.hardcoded;
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: save,
                    child: Text(context.$.signUp),
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
      _formKey.currentState!.save();
      _userBloc.add(
        UserEvent.createUser(
          CreateUserParams(
            username: _username,
            firstName: _firstName,
            lastName: _lastName,
            email: _email,
            password: _password,
          ),
        ),
      );
    }
  }
}
