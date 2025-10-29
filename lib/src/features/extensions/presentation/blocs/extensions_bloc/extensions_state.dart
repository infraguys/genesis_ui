part of 'extensions_bloc.dart';

sealed class ExtensionsState {}

final class ExtensionsInitialState implements ExtensionsState {}

final class ExtensionsLoadingState implements ExtensionsState {}

final class ExtensionsLoadedState implements ExtensionsState {
  ExtensionsLoadedState(this.extensions);

  final List<Extension> extensions;
}
