import 'package:genesis/src/features/common/shared_entities/status.dart';

final class CreateOrganizationParams {
  const CreateOrganizationParams({
    required this.name,
    this.description,
    this.info,
  });

  final String name;
  final String? description;
  final Map<String, dynamic>? info;
  final Status status = Status.active;

  @override
  String toString() {
    return '''
CreateOrganizationParams(
  name: $name,
  description: $description,
  info: $info,
  status: $status,
)''';
  }
}
