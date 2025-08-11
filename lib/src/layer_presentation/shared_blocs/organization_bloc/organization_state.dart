part of 'organization_bloc.dart';

sealed class OrganizationState {
  factory OrganizationState.initial() = OrganizationStateInitial;

  factory OrganizationState.loading() = OrganizationStateLoading;

  factory OrganizationState.success() = OrganizationStateSuccess;

  factory OrganizationState.failure(String message) = OrganizationStateFailure;
}

final class OrganizationStateInitial implements OrganizationState {}

final class OrganizationStateLoading implements OrganizationState {}

final class OrganizationStateSuccess implements OrganizationState {}

final class OrganizationStateFailure implements OrganizationState {
  OrganizationStateFailure(this.message);

  final String message;
}
