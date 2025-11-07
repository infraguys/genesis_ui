import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/page_blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_input.dart';

class _DomainSetupPage extends StatefulWidget {
  const _DomainSetupPage({super.key});  // ignore: unused_element_parameter

  @override
  State<_DomainSetupPage> createState() => _DomainSetupPageState();
}

class _DomainSetupPageState extends State<_DomainSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DomainSetupCubit, DomainSetupState>(
      listenWhen: (_, current) => current is DomainSetupWrittenState,
      listener: (context, state) {
        switch (state) {
          case DomainSetupWrittenState(:final apiUrl):
            context.read<AuthBloc>().add(AuthEvent.restoreSession());
          default:
        }
      },
      child: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.3,
            ),
            child: Column(
              spacing: 16.0,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  key: _formKey,
                  child: AppTextInput(controller: _controller),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<DomainSetupCubit>().writeApiUrl(_controller.text);
                    }
                  },
                  child: const Text('Set domain'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DomainSetupPage extends StatelessWidget {
  const DomainSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _DomainSetupPage();
  }
}
