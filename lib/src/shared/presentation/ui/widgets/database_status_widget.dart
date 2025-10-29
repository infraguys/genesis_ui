import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/typedefs/status_view_params.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/base_status_widget.dart';

class DatabaseStatusWidget extends StatelessWidget {
  const DatabaseStatusWidget({required DatabaseStatus status, super.key}) : _status = status;

  final DatabaseStatus _status;

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
      case DatabaseStatus.newStatus:
        return (
          text: context.$.newStatus,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case DatabaseStatus.inProgress:
        return (
          text: context.$.inProgress,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case DatabaseStatus.active:
        return (
          text: context.$.active,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case DatabaseStatus.error:
        return (
          text: context.$.error,
          color: Palette.colorF04C4C,
          labelColor: Palette.colorF04C4C.withValues(alpha: 0.10),
        );
      case DatabaseStatus.unknown:
        return (
          text: context.$.unknown,
          color: Palette.colorF04C4C,
          labelColor: Palette.colorF04C4C.withValues(alpha: 0.10),
        );
    }
  }
}
