import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';

abstract class OrganizationsEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/iam/organizations/');
  }

  static Endpoint item(OrganizationID id) {
    return Endpoint.withCorePrefix('/iam/organizations/$id');
  }
}
