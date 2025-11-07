part of './domain_setup_cubit.dart';

sealed class DomainSetupState {}

final class _InitialState implements DomainSetupState {}

final class DomainSetupLoadingState implements DomainSetupState {}

final class DomainSetupEmptyState implements DomainSetupState {}

final class DomainSetupWrittenState implements DomainSetupState {
  DomainSetupWrittenState(this.apiUrl);

  final String apiUrl;
}

final class DomainSetupReadState implements DomainSetupState {
  DomainSetupReadState(this.apiUrl);

  final String apiUrl;
}
