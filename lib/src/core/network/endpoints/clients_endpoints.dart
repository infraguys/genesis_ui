import 'package:genesis/src/core/env/env.dart';

abstract class ClientsEndpoints {
  static const getToken = '/${Env.versionApi}/iam/clients/${Env.iamClientUuid}/actions/get_token/invoke';
  static const getMe = '/${Env.versionApi}/iam/clients/${Env.iamClientUuid}/actions/me';
}
