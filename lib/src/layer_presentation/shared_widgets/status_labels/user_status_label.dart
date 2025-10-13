import 'package:flutter/material.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/base_status_label.dart';
import 'package:genesis/src/theming/palette.dart';

class UserStatusLabel extends StatelessWidget {
  const UserStatusLabel({required UserStatus status, super.key}) : _status = status;

  final UserStatus _status;

  Color get textStatusColor => switch (_status) {
    UserStatus.active => Palette.color6DCF91,
    _ => Palette.colorF04C4C
  };

  Color get labelStatusColor => switch (_status) {
    UserStatus.active => Palette.color6DCF91.withValues(alpha: 0.10),
    _ => Palette.colorF04C4C.withValues(alpha: 0.10)
  };

  @override
  Widget build(BuildContext context) {
    return BaseStatusLabel(
      status: _status,
      textStatusColor: textStatusColor,
      labelStatusColor: labelStatusColor,
    );
  }
}
