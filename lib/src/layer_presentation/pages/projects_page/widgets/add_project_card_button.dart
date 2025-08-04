import 'package:flutter/material.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/widgets/create_project_dialog.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/add_card_button.dart';

class AddProjectCardButton extends StatelessWidget {
  const AddProjectCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AddCardButton(child: CreateProjectDialog());
  }
}
