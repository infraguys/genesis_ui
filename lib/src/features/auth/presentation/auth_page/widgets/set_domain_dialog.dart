import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/bootstrap/presentation/blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_from_input.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/general_dialog_layout.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/save_icon_button.dart';
import 'package:go_router/go_router.dart';

class SetDomainDialog extends StatefulWidget {
  const SetDomainDialog({super.key});

  @override
  State<SetDomainDialog> createState() => _SetDomainDialogState();
}

class _SetDomainDialogState extends State<SetDomainDialog> {
  late final DomainSetupCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<DomainSetupCubit>();
    final state = _cubit.state;
    _url = state is DomainSetupReadState ? state.apiUrl : Env.baseUrl;

    super.initState();
  }

  late String _url;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GeneralDialogLayout(
      child: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: .end,
          mainAxisSize: .min,
          children: [
            Form(
              key: _formKey,
              child: AppTextFormInput(
                initialValue: _url,
                onSaved: (value) => _url = value!.trim(),
                helperText: 'Введите адрес вашего домена'.hardcoded,
              ),
            ),
            SaveIconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _cubit.writeApiUrl(_url);
                  context.pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
