import 'package:genesis/src/core/env/env.dart';

abstract class ClientsEndpoints {
  static final _clients = '/${Env.versionApi}/iam/clients';

  static String getToken() => '$_clients/${Env.iamClientUuid}/actions/get_token/invoke';

  static String getMe() => '$_clients/${Env.iamClientUuid}/actions/me';
}
