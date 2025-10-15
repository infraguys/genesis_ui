import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/typedefs/status_view_params.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/base_status_widget.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class PermissionStatusWidget extends StatelessWidget {
  const PermissionStatusWidget({
    required PermissionStatus status,
    super.key,
  }) : _status = status;

  final PermissionStatus _status;

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
      case PermissionStatus.active:
        return (
          text: context.$.active,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case PermissionStatus.unknown:
        return (
          text: context.$.unknown,
          color: Palette.colorF04C4C,
          labelColor: Palette.colorF04C4C.withValues(alpha: 0.10),
        );
    }
  }
}
