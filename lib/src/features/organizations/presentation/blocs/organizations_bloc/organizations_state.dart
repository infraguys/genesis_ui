part of 'organizations_bloc.dart';

sealed class OrganizationsState {}

final class OrganizationsInitialState implements OrganizationsState {}

final class OrganizationsLoadingState implements OrganizationsState {}

final class OrganizationsLoadedState extends _OrganizationsDataState {
  OrganizationsLoadedState(super.organizations);
}

final class OrganizationsDeletedState extends _OrganizationsDataState {
  OrganizationsDeletedState(super.organizations);
}

final class OrganizationsFailureState extends _FailureState {
  OrganizationsFailureState(super.message);
}

final class OrganizationsPermissionFailureState extends _FailureState {
  OrganizationsPermissionFailureState(super.message);
}

// Base classes to reduce code duplication
base class _OrganizationsDataState implements OrganizationsState {
  _OrganizationsDataState(this.organizations);

  final List<Organization> organizations;
}

base class _FailureState implements OrganizationsState {
  _FailureState(this.message);

  final String message;
}
