part of 'organization_bloc.dart';

sealed class OrganizationState {
  factory OrganizationState.initial() = OrganizationInitialState;

  factory OrganizationState.loading() = OrganizationLoadingState;

  factory OrganizationState.created() = OrganizationCreatedState;

  factory OrganizationState.updated(Organization organization) = OrganizationUpdatedState;

  factory OrganizationState.deleted(Organization organization) = OrganizationDeletedState;

  factory OrganizationState.failure(String message) = OrganizationFailureState;
}

final class OrganizationInitialState implements OrganizationState {}

final class OrganizationLoadingState implements OrganizationState {}

final class OrganizationCreatedState implements OrganizationState {}

final class OrganizationUpdatedState implements OrganizationState {
  OrganizationUpdatedState(this.organization);

  final Organization organization;
}

final class OrganizationDeletedState implements OrganizationState {
  OrganizationDeletedState(this.organization);

  final Organization organization;
}

final class OrganizationFailureState implements OrganizationState {
  OrganizationFailureState(this.message);

  final String message;
}
