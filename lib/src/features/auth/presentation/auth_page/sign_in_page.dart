import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/features/auth/presentation/auth_page/widgets/sign_in_form.dart';
import 'package:genesis/src/features/auth/presentation/auth_page/widgets/sign_up_form.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/spacing.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';

enum AuthMode { signIn, signUp }

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthMode mode = AuthMode.signIn;

  void _toggle() {
    FocusScope.of(context).unfocus();
    setState(() => mode = mode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn);
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
                      child: PageTransitionSwitcher(
                        transitionBuilder: (child, primary, secondary) => SharedAxisTransition(
                          fillColor: Palette.color1B1B1D,
                          transitionType: SharedAxisTransitionType.horizontal,
                          animation: primary,
                          secondaryAnimation: secondary,
                          child: child,
                        ),
                        child: mode == AuthMode.signIn
                            ? SignInForm(key: const ValueKey('signIn'), onTap: _toggle)
                            : SignUpForm(key: const ValueKey('signUp'), onTap: _toggle),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
