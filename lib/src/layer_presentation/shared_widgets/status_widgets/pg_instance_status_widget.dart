import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/typedefs/status_view_params.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/base_status_widget.dart';
import 'package:genesis/src/theming/palette.dart';

class PgInstanceStatusWidget extends StatelessWidget {
  const PgInstanceStatusWidget({required PgInstanceStatus status, super.key}) : _status = status;

  final PgInstanceStatus _status;

  @override
  Widget build(BuildContext context) {
    final params = _getStatusParams(context);
    return BaseStatusWidget(
      text: params.text,
      color: params.color,
      labelColor: params.labelColor,
    );
  }

  StatusViewParams _getStatusParams(BuildContext context) {
    switch (_status) {
      case PgInstanceStatus.newStatus:
        return (
          text: context.$.newStatus,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case PgInstanceStatus.inProgress:
        return (
          text: context.$.inProgress,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case PgInstanceStatus.active:
        return (
          text: context.$.active,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case PgInstanceStatus.error:
        return (
          text: context.$.error,
          color: Palette.colorF04C4C,
          labelColor: Palette.colorF04C4C.withValues(alpha: 0.10),
        );
      case PgInstanceStatus.unknown:
        return (
          text: context.$.unknown,
          color: Palette.colorF04C4C,
          labelColor: Palette.colorF04C4C.withValues(alpha: 0.10),
        );
    }
  }
}
