part of 'organization_bloc.dart';

sealed class OrganizationState {
  factory OrganizationState.initial() = OrganizationInitialState;

  factory OrganizationState.loading() = OrganizationLoadingState;

  factory OrganizationState.created() = OrganizationUpdatedState;

  factory OrganizationState.updated() = OrganizationUpdatedState;

  factory OrganizationState.deleted() = OrganizationDeletedState;

  factory OrganizationState.failure(String message) = OrganizationFailureState;
}

final class OrganizationInitialState implements OrganizationState {}

final class OrganizationLoadingState implements OrganizationState {}

final class OrganizationCreatedState implements OrganizationState {}

final class OrganizationUpdatedState implements OrganizationState {}

final class OrganizationDeletedState implements OrganizationState {}

final class OrganizationFailureState implements OrganizationState {
  OrganizationFailureState(this.message);

  final String message;
}
