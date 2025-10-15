import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';

abstract class OrganizationsEndpoints {
  static const _organizations = '${Env.apiPrefix}/${Env.versionApi}/iam/organizations/';
  static const _organization = '$_organizations:id';

  static String getOrganizations() => _organizations;

  static String createOrganization() => _organizations;

  static String getOrganization(OrganizationID id) => _organization.withID(id);

  static String updateOrganization(OrganizationID id) => _organization.withID(id);

  static String deleteOrganization(OrganizationID id) => _organization.withID(id);
}

// ignore: camel_case_extensions
extension _ on String {
  String withID(OrganizationID id) => replaceFirst(':id', id.value);
}
