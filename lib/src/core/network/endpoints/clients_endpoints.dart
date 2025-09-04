import 'package:genesis/src/core/env/env.dart';

abstract class ClientsEndpoints {
  static const _clients = '/iam/clients';

  static String getToken() => '$_clients/${Env.iamClientUuid}/actions/get_token/invoke';

  static String getMe() => '$_clients/${Env.iamClientUuid}/actions/me';
}
