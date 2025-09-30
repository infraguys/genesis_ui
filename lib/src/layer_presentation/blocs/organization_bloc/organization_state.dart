part of 'organization_bloc.dart';

sealed class OrganizationState {
  factory OrganizationState.loading() = OrganizationLoadingState;

  factory OrganizationState.initial() = OrganizationLoadingState;

  factory OrganizationState.created() = OrganizationCreatedState;

  factory OrganizationState.updated(Organization organization) = OrganizationUpdatedState;

  factory OrganizationState.deleted(Organization organization) = OrganizationDeletedState;

  factory OrganizationState.failure(String message) = OrganizationFailureState;

  factory OrganizationState.permissionFailure(String message) = OrganizationPermissionFailureState;

  factory OrganizationState.loaded(Organization organization) = OrganizationLoadedState;
}

final class OrganizationInitialState implements OrganizationState {}

final class OrganizationLoadingState implements OrganizationState {}

final class OrganizationLoadedState implements OrganizationState {
  OrganizationLoadedState(this.organization);

  final Organization organization;
}

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

final class OrganizationPermissionFailureState implements OrganizationState {
  OrganizationPermissionFailureState(this.message);

  final String message;
}
