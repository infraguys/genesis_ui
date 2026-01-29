abstract class IRequest {
  const IRequest();

  Map<String, dynamic>? get body => null;

  Map<String, dynamic>? get query => null;

  String get path;
}
