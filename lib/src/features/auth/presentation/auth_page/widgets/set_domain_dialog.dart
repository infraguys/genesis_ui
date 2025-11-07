import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/page_blocs/server_setup_cubit/domain_setup_cubit.dart';
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
  var _url = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GeneralDialogLayout(
      child: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<DomainSetupCubit, DomainSetupState>(
              builder: (context, state) {
                _url = state is DomainSetupReadState ? state.apiUrl : '';
                return Form(
                  key: _formKey,
                  child: AppTextFormInput(
                    initialValue: _url,
                    onSaved: (value) => _url = value!.trim(),
                    helperText: 'Введите адрес вашего домена'.hardcoded,
                  ),
                );
              },
            ),
            SaveIconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.pop(_url);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
