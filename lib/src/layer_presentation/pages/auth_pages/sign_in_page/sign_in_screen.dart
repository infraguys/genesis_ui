import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/features/iam_client/domain/params/get_token_params.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _isPasswordVisible = ValueNotifier(false);

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
        body: LayoutBuilder(
          builder: (context, constraints) {
            final columnWidth = constraints.maxWidth / 3;
            return Row(
              children: [
                Container(
                  width: columnWidth * 2,
                  color: Palette.color1B1B1D,
                  child: Center(
                    child: Column(
                      spacing: Spacing.s16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: 200,
                          height: 200,
                        ),
                        Text(
                          '${context.$.genesis} ${context.$.core}',
                          style: textTheme.headlineLarge?.copyWith(color: Colors.white24),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(width: 2, thickness: 2, color: Palette.color333333, indent: 100, endIndent: 100),
                Container(
                  width: columnWidth - 2,
                  color: Palette.color1B1B1D,
                  child: Center(
                    child: SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: Spacing.s16,
                        children: [
                          Column(
                            children: [
                              Text('Welcome', style: textTheme.headlineLarge!.w400 + Colors.white24),
                              Text(
                                'Please Login to Genesis Core',
                                style: textTheme.headlineSmall!.w400 + Colors.white24,
                              ),
                            ],
                          ),
                          SizedBox(height: Spacing.s32),
                          Form(
                            key: _formKey,
                            child: Column(
                              spacing: Spacing.s16,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppTextFormInput(
                                  helperText: 'Login'.hardcoded,
                                  onSaved: (newValue) => _username = newValue!,
                                  maxLines: 1,
                                  // suffixIcon: Icon(Icons.person, color: Colors.white24),
                                  validator: (value) => switch (value) {
                                    _ when value!.isEmpty => context.$.requiredField,
                                    _ => null,
                                  },
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _isPasswordVisible,
                                  builder: (context, isVisible, _) {
                                    return AppTextFormInput.password(
                                      helperText: context.$.password,
                                      obscureText: !isVisible,
                                      suffixIcon: GestureDetector(
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Icon(
                                            applyTextScaling: true,
                                            isVisible ? Icons.visibility : Icons.visibility_off,
                                            color: Colors.white24,
                                          ),
                                        ),
                                        onTap: () => _isPasswordVisible.value = !isVisible,
                                      ),
                                      onSaved: (newValue) => _password = newValue!,
                                      validator: (value) => switch (value) {
                                        _ when value!.isEmpty => context.$.requiredField,
                                        _ => null,
                                      },
                                    );
                                  },
                                ),
                                SizedBox(height: Spacing.s16),
                                ElevatedButton(
                                  onPressed: signIn,
                                  child: Text('Login'.toUpperCase().hardcoded),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: textTheme.bodyMedium!.copyWith(color: Colors.white24),
                              children: [
                                const TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: 'Sign up',
                                  style: textTheme.bodyMedium! + Palette.colorFF8900,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // TODO: переход на экран регистрации
                                      debugPrint('Navigate to Sign up');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        // child: Form(
        //   key: _formKey,
        //   child: ConstrainedBox(
        //     constraints: BoxConstraints(maxWidth: 300),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.stretch,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       spacing: 20,
        //       children: [
        //         SvgPicture.asset(
        //           'assets/images/logo.svg',
        //           width: 250,
        //           height: 250,
        //         ),
        //         Text(
        //           '${context.$.genesis} ${context.$.core}',
        //           style: textTheme.headlineLarge?.copyWith(color: Colors.white),
        //           textAlign: TextAlign.center,
        //         ),
        //         TextFormField(
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           style: TextStyle(color: Colors.white),
        //           decoration: InputDecoration(hintText: 'Login'.hardcoded),
        //           onSaved: (newValue) => _username = newValue!,
        //           validator: (value) => switch (value) {
        //             _ when value!.isEmpty => context.$.requiredField,
        //             _ => null,
        //           },
        //         ),
        //         TextFormField(
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           style: TextStyle(color: Colors.white),
        //           decoration: InputDecoration(hintText: context.$.password),
        //           obscureText: true,
        //           onSaved: (newValue) => _password = newValue!,
        //           validator: (value) => switch (value) {
        //             _ when value!.isEmpty => context.$.requiredField,
        //             _ => null,
        //           },
        //         ),
        //         ElevatedButton(
        //           onPressed: signIn,
        //           child: Text(context.$.signIn),
        //         ),
        //         ElevatedButton(
        //           onPressed: () async {
        //             final username = await context.pushNamed<String>(AppRoutes.signUp.name);
        //             if (username != null) {
        //               _username = username;
        //             }
        //           },
        //           child: Text(context.$.signUp),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  void signIn() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _authBloc.add(
        AuthEvent.signIn(GetTokenParams(username: _username, password: _password)),
      );
    }
  }
}
