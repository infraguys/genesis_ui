abstract class OrganizationsEndpoints {
  static const _organizations = '/iam/organizations/';
  static const _organization = '/iam/organizations/:uuid';

  static String getOrganizations() => _organizations;

  static String createOrganization() => _organizations;

  static String getOrganization(String uuid) => _organization.fillUuid(uuid);

  static String updateOrganization(String uuid) => _organization.fillUuid(uuid);

  static String deleteOrganization(String uuid) => _organization.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
