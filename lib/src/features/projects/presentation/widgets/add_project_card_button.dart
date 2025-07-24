import 'package:flutter/material.dart';
import 'package:genesis/src/features/common/shared_widgets/add_card_button.dart';
import 'package:genesis/src/features/projects/presentation/widgets/create_project_dialog.dart';

class AddProjectCardButton extends StatelessWidget {
  const AddProjectCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AddCardButton(child: CreateProjectDialog());
  }
}
