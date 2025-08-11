import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';

final class GetProjectReq implements PathEncodable {
  GetProjectReq(this._user);

  final String _user;

  @override
  String toPath() {
    return ProjectsEndpoints.getProject.replaceFirst(':uuid', _user.split('/').last);
  }
}
