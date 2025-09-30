part of 'organizations_bloc.dart';

sealed class OrganizationsState {
  bool get shouldRebuildList => this is OrganizationsLoadedState || this is OrganizationsLoadingState;
}

final class OrganizationsInitialState extends OrganizationsState {}

final class OrganizationsLoadingState extends OrganizationsState {}

final class OrganizationsLoadedState extends OrganizationsState {
  OrganizationsLoadedState(this.organizations);

  final List<Organization> organizations;
}

final class OrganizationsDeletedState extends OrganizationsState {
  OrganizationsDeletedState(this.organizations);

  final List<Organization> organizations;
}

final class OrganizationsPermissionFailureState extends OrganizationsState {
  OrganizationsPermissionFailureState(this.message);

  final String message;
}
