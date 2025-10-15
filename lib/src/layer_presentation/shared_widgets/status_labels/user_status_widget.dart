import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/base_status_label.dart';
import 'package:genesis/src/theming/palette.dart';

class UserStatusWidget extends StatelessWidget {
  const UserStatusWidget({required UserStatus status, super.key}) : _status = status;

  final UserStatus _status;

  ({String text, Color color, Color labelColor}) _getStatusParams(
    BuildContext context,
    UserStatus status,
  ) {
    switch (status) {
      case UserStatus.active:
        return (
          text: context.$.active,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      default:
        return (
          text: context.$.unknown,
          color: Palette.colorF04C4C,
          labelColor: Palette.colorF04C4C.withValues(alpha: 0.10),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final params = _getStatusParams(context, _status);
    return BaseStatusWidget(
      text: params.text,
      color: params.color,
      labelColor: params.labelColor,
    );
  }
}
