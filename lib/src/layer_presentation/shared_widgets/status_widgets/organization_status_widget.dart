import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/typedefs/status_view_params.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/base_status_widget.dart';
import 'package:genesis/src/theming/palette.dart';

class OrganizationStatusWidget extends StatelessWidget {
  const OrganizationStatusWidget({
    required OrganizationStatus status,
    super.key,
  }) : _status = status;

  final OrganizationStatus _status;

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
      case OrganizationStatus.active:
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
}
