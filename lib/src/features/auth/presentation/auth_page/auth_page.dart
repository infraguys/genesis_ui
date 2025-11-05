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

enum _AuthMode { signIn, signUp }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final authNotifier = ValueNotifier<_AuthMode>(_AuthMode.signIn);

  void _toggle() {
    FocusScope.of(context).unfocus();
    authNotifier.value = switch (authNotifier.value) {
      _AuthMode.signIn => _AuthMode.signUp,
      _AuthMode.signUp => _AuthMode.signIn,
    };
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
                          style: textTheme.headlineLarge?.copyWith(
                            color: Colors.white24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(width: 2, thickness: 2, color: Palette.color333333, indent: 100, endIndent: 100),
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 400,
                          child: ValueListenableBuilder(
                            valueListenable: authNotifier,
                            builder: (context, value, child) {
                              return PageTransitionSwitcher(
                                transitionBuilder: (child, primary, secondary) => SharedAxisTransition(
                                  fillColor: Palette.color1B1B1D,
                                  transitionType: SharedAxisTransitionType.horizontal,
                                  animation: primary,
                                  secondaryAnimation: secondary,
                                  child: child,
                                ),
                                child: switch (value) {
                                  _AuthMode.signIn => SignInForm(key: const ValueKey('signIn'), onTap: _toggle),
                                  _AuthMode.signUp => SignUpForm(key: const ValueKey('signUp'), onTap: _toggle),
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentGeometry.topRight,
                        child: IconButton(
                          onPressed: () async {
                            // final url = await showDialog<String>(
                            //   context: context,
                            //   builder: (context) {
                            //     return Dialog(
                            //       child: SetupDomainDialog(),
                            //     );
                            //   },
                            // );
                            // context.read<RestClient>().setBaseUrl(url ?? '');
                          },
                          icon: Icon(Icons.settings, color: Colors.white24),
                        ),
                      ),
                    ],
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
