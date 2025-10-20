import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/network/endpoints/endpoint.dart';

abstract class ClientsEndpoints {
  static Endpoint getToken() {
    return Endpoint.withCorePrefix('/iam/clients/${Env.iamClientUuid}/actions/get_token/invoke');
  }

  static Endpoint getMe() {
    return Endpoint.withCorePrefix('/iam/clients/${Env.iamClientUuid}/actions/me');
  }

  static Endpoint introspectIamClient() {
    return Endpoint.withCorePrefix('/iam/clients/${Env.iamClientUuid}/actions/introspect');
  }
}
