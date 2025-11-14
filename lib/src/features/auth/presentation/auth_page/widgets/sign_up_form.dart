import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _isPasswordVisible = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();

  var _username = '';
  var _email = '';
  var _password = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Column(
      crossAxisAlignment: .stretch,
      mainAxisAlignment: .center,
      spacing: Spacing.s16,
      children: [
        Column(
          children: [
            Text('Create account', style: textTheme.headlineLarge!.w400 + Colors.white24),
            Text(
              'Please register to access Genesis Core',
              style: textTheme.headlineSmall!.w400 + Colors.white24,
            ),
          ],
        ),
        SizedBox(height: Spacing.s32),
        Form(
          key: _formKey,
          child: Column(
            spacing: Spacing.s16,
            crossAxisAlignment: .stretch,
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
              AppTextFormInput(
                helperText: 'Email'.hardcoded,
                onSaved: (newValue) => _email = newValue!,
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AuthBloc>().add(
                      .signUp(
                        username: _username,
                        email: _email,
                        password: _password,
                      ),
                    );
                  }
                },
                child: Text('Login'.toUpperCase().hardcoded),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: .center,
          text: TextSpan(
            style: textTheme.bodyMedium!.copyWith(color: Colors.white24),
            children: [
              const TextSpan(text: 'Already have an account? '),
              TextSpan(
                text: 'Sign In',
                style: textTheme.bodyMedium! + Palette.colorFF8900,
                recognizer: TapGestureRecognizer()..onTap = widget.onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
