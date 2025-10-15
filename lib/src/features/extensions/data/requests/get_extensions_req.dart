import 'package:genesis/src/core/network/endpoints/extensions_endpoints.dart';
import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';

extension GetExtensionsReqExt on GetExtensionsParams {
  Map<String, dynamic> toQuery() {
    return {
      'name': ?name,
      'description': ?description,
      'created_at': ?createdAt?.toIso8601String(),
      'updated_at': ?updatedAt?.toIso8601String(),
      'status': ?_statusToJson(status),
      'version': ?version,
      'install_type': ?installType,
      'link': ?link,
    };
  }

  String? _statusToJson(ExtensionStatus? status) => switch (status) {
    ExtensionStatus.newStatus => 'NEW',
    ExtensionStatus.active => 'ACTIVE',
    ExtensionStatus.inProgress => 'IN_PROGRESS',
    _ => null,
  };

  String toPath() => ExtensionsEndpoints.getExtensions();
}
