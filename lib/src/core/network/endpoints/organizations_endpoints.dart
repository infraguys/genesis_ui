import 'package:genesis/src/core/env/env.dart';

abstract class OrganizationsEndpoints {
  static const String _organizations = '/${Env.versionApi}/iam/organizations/';
  static const String _organization = '/${Env.versionApi}/iam/organizations/:uuid';

  static const String getOrganizations = _organizations;
  static const String createOrganization = _organizations;
  static const String getOrganization = _organization;
  static const String updateOrganization = _organization;
  static const String deleteOrganization = _organization;
}
