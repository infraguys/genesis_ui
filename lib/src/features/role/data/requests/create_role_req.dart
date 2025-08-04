import 'package:genesis/src/features/role/domain/params/create_role_params.dart';

final class CreateRoleReq {
  CreateRoleReq(CreateRoleParams params) : _name = params.name, _description = params.description;

  final String _name;
  final String? _description;

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'description': _description,
    };
  }
}
