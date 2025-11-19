part of 'domain_setup_cubit.dart';

sealed class DomainSetupState extends Equatable {
  const DomainSetupState();

  bool get isInitial => this is _InitialState;
}

final class _InitialState extends DomainSetupState {
  const _InitialState();

  @override
  List<Object?> get props => [];
}

final class DomainSetupLoadingState extends DomainSetupState {
  const DomainSetupLoadingState();

  @override
  List<Object?> get props => [];
}

final class DomainSetupEmptyState extends DomainSetupState {
  const DomainSetupEmptyState();

  @override
  List<Object?> get props => [];
}

final class DomainSetupWrittenState extends DomainSetupState {
  const DomainSetupWrittenState(this.apiUrl);

  final String apiUrl;

  @override
  List<Object?> get props => [apiUrl];
}

final class DomainSetupReadState extends DomainSetupState {
  const DomainSetupReadState(this.apiUrl);

  final String apiUrl;

  @override
  List<Object?> get props => [apiUrl];
}
