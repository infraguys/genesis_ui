import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genesis/src/layer_presentation/blocs/app_bloc/app_bloc.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppBloc, AppState>(
        listenWhen: (previous, current) => current is AppInitializedState,
        listener: (context, state) {
          context.goNamed(AppRoutes.main.name);
        },
        child: Center(
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
