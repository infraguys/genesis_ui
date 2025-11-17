import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/page_blocs/server_setup_cubit/domain_setup_cubit.dart';

class _View extends StatelessWidget {
  const _View({super.key});

  // ignore: unused_element_parameter
  @override
  Widget build(BuildContext context) {
    return BlocListener<DomainSetupCubit, DomainSetupState>(
      // listenWhen: (_, current) => current.isNotInitial,
      listener: (context, state) {
        if (state is DomainSetupReadState) {
          Env.baseUrl = state.apiUrl;
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<DomainSetupCubit>().readApiUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const _View();
  }
}
