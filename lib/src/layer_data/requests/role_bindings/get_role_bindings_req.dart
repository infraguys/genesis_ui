import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';

final class GetRoleBindingsReq implements QueryEncodable, PathEncodable {
  GetRoleBindingsReq({required String? userUuid}) : _userUuid = userUuid;

  final String? _userUuid;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'user': ?_userUuid,
    };
  }

  @override
  String toPath() {
    return RoleBindingsEndpoints.getRoleBindings;
  }
}
