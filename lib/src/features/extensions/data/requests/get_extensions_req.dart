import 'package:genesis/src/core/network/endpoints/extensions_endpoints.dart';
import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:genesis/src/features/extensions/domain/params/get_extensions_params.dart';

final class GetExtensionsReq {
  GetExtensionsReq(this._params);

  final GetExtensionsParams _params;

  Map<String, dynamic> toQuery() {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?_fromStatusToQuery(_params.status),
      'version': ?_params.version,
      'install_type': ?_params.installType,
      'link': ?_params.link,
    };
  }

  String? _fromStatusToQuery(ExtensionStatus? status) => switch (status) {
    ExtensionStatus.newStatus => 'NEW',
    ExtensionStatus.active => 'ACTIVE',
    ExtensionStatus.inProgress => 'IN_PROGRESS',
    _ => null,
  };

  String toPath() => ExtensionsEndpoints.getExtensions();
}
