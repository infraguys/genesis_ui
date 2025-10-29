part of 'extensions_bloc.dart';

sealed class ExtensionsEvent {
  factory ExtensionsEvent.getExtensions([GetExtensionsParams params]) = _GetExtensions;
}

final class _GetExtensions implements ExtensionsEvent {
  _GetExtensions([this.params = const GetExtensionsParams()]);

  final GetExtensionsParams params;
}
