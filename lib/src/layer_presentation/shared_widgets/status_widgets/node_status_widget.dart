import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/typedefs/status_view_params.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/base_status_widget.dart';
import 'package:genesis/src/theming/palette.dart';

class NodeStatusWidget extends StatelessWidget {
  const NodeStatusWidget({
    required NodeStatus status,
    super.key,
  }) : _status = status;

  final NodeStatus _status;

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
      case NodeStatus.newStatus:
        return (
          text: context.$.newStatus,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case NodeStatus.started:
        return (
          text: context.$.started,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case NodeStatus.active:
        return (
          text: context.$.active,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case NodeStatus.inProgress:
        return (
          text: context.$.inProgress,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case NodeStatus.scheduled:
        return (
          text: context.$.scheduled,
          color: Palette.color6DCF91,
          labelColor: Palette.color6DCF91.withValues(alpha: 0.10),
        );
      case NodeStatus.error:
        return (
          text: context.$.error,
          color: Palette.colorF04C4C,
          labelColor: Palette.colorF04C4C.withValues(alpha: 0.10),
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
