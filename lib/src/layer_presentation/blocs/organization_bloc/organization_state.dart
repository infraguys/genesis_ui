part of 'organization_bloc.dart';

sealed class OrganizationState {
  factory OrganizationState.loading() = OrganizationLoadingState;

  factory OrganizationState.initial() = OrganizationLoadingState;

  factory OrganizationState.created(Organization organization) = OrganizationCreatedState;

  factory OrganizationState.creating() = OrganizationCreatingState;

  factory OrganizationState.updated(Organization organization) = OrganizationUpdatedState;

  factory OrganizationState.deleted(Organization organization) = OrganizationDeletedState;

  factory OrganizationState.deleting() = OrganizationDeletingState;

  factory OrganizationState.failure(String message) = OrganizationFailureState;

  factory OrganizationState.permissionFailure(String message) = OrganizationPermissionFailureState;

  factory OrganizationState.loaded(Organization organization) = OrganizationLoadedState;
}

final class OrganizationInitialState implements OrganizationState {}

final class OrganizationLoadingState implements OrganizationState {}

final class OrganizationCreatingState implements OrganizationState {}

final class OrganizationDeletingState implements OrganizationState {}

final class OrganizationCreatedState extends _OrganizationDataState {
  OrganizationCreatedState(super.organization);
}

final class OrganizationLoadedState extends _OrganizationDataState {
  OrganizationLoadedState(super.organization);
}

final class OrganizationUpdatedState extends _OrganizationDataState {
  OrganizationUpdatedState(super.organization);
}

final class OrganizationDeletedState extends _OrganizationDataState {
  OrganizationDeletedState(super.organization);
}

final class OrganizationFailureState extends _FailureState {
  OrganizationFailureState(super.message);
}

final class OrganizationPermissionFailureState extends _FailureState {
  OrganizationPermissionFailureState(super.message);
}

// Base classes to reduce code duplication

base class _OrganizationDataState implements OrganizationState {
  _OrganizationDataState(this.organization);

  final Organization organization;
}

base class _FailureState implements OrganizationState {
  _FailureState(this.message);

  final String message;
}
