import 'package:genesis/src/layer_domain/entities/status.dart';

final class EditOrganizationParams {
  const EditOrganizationParams({
    required this.uuid,
    required this.name,
    this.description,
    this.status,
    this.info,
  });

  final String uuid;
  final String name;
  final String? description;
  final Status? status;
  final Map<String, dynamic>? info;
}
