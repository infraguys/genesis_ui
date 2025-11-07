import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/page_blocs/server_setup_cubit/domain_setup_cubit.dart';

class _View extends StatelessWidget {
  const _View({super.key}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    return BlocListener<DomainSetupCubit, DomainSetupState>(
      listenWhen: (_, current) => current is DomainSetupReadState,
      listener: (context, state) {
        if (state is DomainSetupReadState) {
          context.read<AuthBloc>().add(AuthEvent.restoreSession());
        }
      },
      child: Scaffold(
        body: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _View();
  }
}
