import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';

final class GetProjectReq implements PathEncodable {
  GetProjectReq(this._uuid);

  final String _uuid;

  @override
  String toPath() {
    return ProjectsEndpoints.getProject.replaceFirst(':uuid', _uuid);
  }
}
