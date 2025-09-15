import 'package:flutter/material.dart';
import 'package:genesis/src/core/interfaces/base_status.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/base_status_label.dart';
import 'package:genesis/src/theming/palette.dart';

class NodeStatusLabel extends StatelessWidget {
  const NodeStatusLabel({required NodeStatus status, super.key}) : _status = status;

  final BaseStatusEnum _status;

  Color get textStatusColor => switch (_status as NodeStatus) {
    NodeStatus.active => Palette.color6DCF91,
    NodeStatus.newStatus => Palette.color6DCF91,
    NodeStatus.inProgress => Palette.color6DCF91,
    NodeStatus.scheduled => Palette.color6DCF91,
    NodeStatus.started => Palette.color6DCF91,
    NodeStatus.error => Palette.colorF04C4C,
  };

  Color get labelStatusColor => switch (_status as NodeStatus) {
    NodeStatus.active => Palette.color6DCF91.withValues(alpha: 0.10),
    NodeStatus.newStatus => Palette.color6DCF91.withValues(alpha: 0.10),
    NodeStatus.inProgress => Palette.color6DCF91.withValues(alpha: 0.10),
    NodeStatus.scheduled => Palette.color6DCF91.withValues(alpha: 0.10),
    NodeStatus.started => Palette.color6DCF91.withValues(alpha: 0.10),
    NodeStatus.error => Palette.colorF04C4C.withValues(alpha: 0.10),
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
