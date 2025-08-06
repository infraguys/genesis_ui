import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/layer_domain/params/get_projects_params.dart';

final class GetProjectsReq implements QueryEncodable {
  GetProjectsReq(this._params);

  final GetProjectsParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'user': _params.userUuid,
    };
  }
}
