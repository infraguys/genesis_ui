import 'package:flutter/material.dart';
import 'package:genesis/src/features/common/shared_widgets/add_card_button.dart';
import 'package:genesis/src/features/role/presentation/widgets/create_role_dialog.dart';

class AddRoleCardButton extends StatelessWidget {
  const AddRoleCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AddCardButton(child: CreateRoleDialog());
  }
}
