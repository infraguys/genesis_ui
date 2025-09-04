part of 'organizations_bloc.dart';

sealed class OrganizationsState {}

final class OrganizationsInitState implements OrganizationsState {}

final class OrganizationsLoadingState implements OrganizationsState {}

final class OrganizationsLoadedState implements OrganizationsState {
  OrganizationsLoadedState(this.organizations);

  final List<Organization> organizations;
}
