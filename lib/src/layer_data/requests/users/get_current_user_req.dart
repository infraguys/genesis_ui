import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';

final class GetCurrentUserReq implements PathEncodable {
  const GetCurrentUserReq();

  @override
  String toPath() => '/iam/clients/${Env.iamClientUuid}/actions/me';
}
