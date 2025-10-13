import 'package:flutter/material.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/base_status_label.dart';
import 'package:genesis/src/theming/palette.dart';

class PgInstanceStatusLabel extends StatelessWidget {
  const PgInstanceStatusLabel({required PgInstanceStatus status, super.key}) : _status = status;

  final PgInstanceStatus _status;

  Color get textStatusColor => switch (_status) {
    PgInstanceStatus.active => Palette.color6DCF91,
    PgInstanceStatus.newStatus => Palette.color6DCF91,
    PgInstanceStatus.inProgress => Palette.color6DCF91,
    _ => Palette.colorF04C4C,
  };

  Color get labelStatusColor => switch (_status) {
    PgInstanceStatus.active => Palette.color6DCF91.withValues(alpha: 0.10),
    PgInstanceStatus.newStatus => Palette.color6DCF91.withValues(alpha: 0.10),
    PgInstanceStatus.inProgress => Palette.color6DCF91.withValues(alpha: 0.10),
    _ => Palette.colorF04C4C.withValues(alpha: 0.10),
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
