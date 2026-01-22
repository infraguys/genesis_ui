part of 'extensions_bloc.dart';

sealed class ExtensionsEvent {
  factory ExtensionsEvent.getExtensions([GetExtensionsParams params = const GetExtensionsParams()]) {
    return _GetExtensions(params);
  }
}

final class _GetExtensions implements ExtensionsEvent {
  _GetExtensions(this.params);

  final GetExtensionsParams params;
}
