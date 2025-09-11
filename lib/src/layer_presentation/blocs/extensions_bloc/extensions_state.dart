part of 'extensions_bloc.dart';

sealed class ExtensionsState {
  factory ExtensionsState.initial() = ExtensionsInitialState;

  factory ExtensionsState.loading() = ExtensionsLoadingState;

  factory ExtensionsState.loaded(List<Extension> extensions) = ExtensionsLoadedState;
}

final class ExtensionsInitialState implements ExtensionsState {}

final class ExtensionsLoadingState implements ExtensionsState {}

final class ExtensionsLoadedState implements ExtensionsState {
  ExtensionsLoadedState(this.extensions);

  final List<Extension> extensions;
}
