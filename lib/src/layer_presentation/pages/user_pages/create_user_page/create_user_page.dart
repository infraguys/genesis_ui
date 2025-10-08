import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_snackbar.dart';
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
    return BlocListener<UserBloc, UserState>(
      listenWhen: (_, current) => switch (current) {
        UserCreatedState() || UserFailureState() => true,
        _ => false,
      },
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        switch (state) {
          case UserCreatedState():
            context.read<UsersBloc>().add(UsersEvent.getUsers());
            messenger.showSnackBar(
              AppSnackBar.success(context.$.msgUserCreated(state.user.username)),
            );
            context.pop();
          case UserFailureState(:final message):
            messenger.showSnackBar(AppSnackBar.failure(message));
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
                        TextFormField(
                          decoration: InputDecoration(hintText: context.$.username),
                          onSaved: (newValue) => _username = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: context.$.firstName),
                          onSaved: (newValue) => _firstName = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: context.$.lastName),
                          onSaved: (newValue) => _lastName = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: context.$.email),
                          onSaved: (newValue) => _email = newValue!,
                          validator: (value) => switch (value) {
                            _ when value!.isEmpty => context.$.requiredField,
                            _ => null,
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: context.$.password),
                          onSaved: (newValue) => _password = newValue!,
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
