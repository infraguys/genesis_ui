import 'package:flutter/material.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/app_text_input.dart';
import 'package:genesis/src/theming/palette.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      child: AppTextInput(
        hintText: 'search',
        controller: TextEditingController(),
        suffixIcon: Icon(Icons.search, color: Palette.color333333),
      ),
    );
  }
}
