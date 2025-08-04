import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:genesis/src/layer_domain/params/get_permissions_params.dart';

final class GetPermissionsReq {
  GetPermissionsReq(GetPermissionsParams params)
    : _name = params.name,
      _description = params.description,
      _createdAt = params.createdAt?.toIso8601String(),
      _updatedAt = params.updatedAt?.toIso8601String(),
      _status = switch (params.status) {
        Status.active => 'ACTIVE',
        _ => null,
      };

  final String? _name;
  final String? _description;
  final String? _createdAt;
  final String? _updatedAt;
  final String? _status;

  Map<String, dynamic> get query {
    return {
      'name': ?_name,
      'description': ?_description,
      'created_at': ?_createdAt,
      'updated_at': ?_updatedAt,
      'status': ?_status,
    };
  }
}
