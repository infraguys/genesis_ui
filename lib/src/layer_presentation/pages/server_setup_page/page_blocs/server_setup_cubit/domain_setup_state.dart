part of './domain_setup_cubit.dart';

sealed class DomainSetupState {
  factory DomainSetupState.initial() = DomainSetupInitialState;

  factory DomainSetupState.loading() = DomainSetupLoadingState;

  factory DomainSetupState.read(String apiUrl) = DomainSetupReadState;

  factory DomainSetupState.written(String apiUrl) = DomainSetupWrittenState;

  factory DomainSetupState.empty() = DomainSetupEmptyState;
}

final class DomainSetupInitialState implements DomainSetupState {}

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
