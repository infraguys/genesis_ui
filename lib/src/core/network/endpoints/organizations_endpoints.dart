import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';

abstract class OrganizationsEndpoints {
  static const _organizations = '/${Env.versionApi}/iam/organizations/';
  static const _organization = '/${Env.versionApi}/iam/organizations/:uuid';

  static String getOrganizations() => _organizations;

  static String createOrganization() => _organizations;

  static String getOrganization(OrganizationUUID uuid) => _organization.fillUuid(uuid);

  static String updateOrganization(OrganizationUUID uuid) => _organization.fillUuid(uuid);

  static String deleteOrganization(OrganizationUUID uuid) => _organization.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(OrganizationUUID uuid) => replaceFirst(':uuid', uuid.value);
}
