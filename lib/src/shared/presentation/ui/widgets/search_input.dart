import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_text_input.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({required this.controller, super.key, this.onChanged});

  final void Function(String value)? onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      child: AppTextInput(
        onChanged: onChanged,
        hintText: context.$.search,
        controller: controller,
        suffixIcon: Icon(Icons.search, color: Palette.color333333),
      ),
    );
  }
}
